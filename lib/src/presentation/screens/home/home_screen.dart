import 'dart:developer';

import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/data/sources/local/main_singleton.dart';
import 'package:city_eye/src/domain/entities/home/job.dart';
import 'package:city_eye/src/domain/entities/home/visitor.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/presentation/blocs/home/home_bloc.dart';
import 'package:city_eye/src/presentation/screens/home/skeleton/skeleton_home_widget.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/check_in_out_widget.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/content_pin_code_widget.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/home_header_section.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/security_items_widget.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/technical_items_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  final searchTextEditingController = TextEditingController();

  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);

  MainSingleton get _mainSingleton => MainSingleton();

  List<VisitorEntity> _visitors = [];
  List<JobEntity> _jobs = [];

  List<VisitorEntity> get allVisitors => _visitors;

  List<VisitorEntity> _searchedVisitors = [];
  List<JobEntity> _searchedJobs = [];

  List<JobEntity> get allJobs => _jobs;

  @override
  void initState() {
    if (_mainSingleton.isUserFound) {
      fetchingDataAccordingPersonType(_mainSingleton.user);
    }
    super.initState();
  }

  @override
  void deactivate() {
    _bloc.add(ShowSkeletonEvent());
    super.deactivate();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, homeState) {
          if (homeState is SuccessFetchAllVisitorsState) {
            _visitors = homeState.visitors;
            _searchedVisitors = _visitors;
          } else if (homeState is SuccessFetchAllJobsState) {
            _jobs = homeState.jobs;
            _searchedJobs = _jobs;
          } else if (homeState is ShowBottomSheetWidgetForSecurityState &&
              _mainSingleton.user.userType == PersonType.security) {
            showBottomSheetWidget(
              context: context,
              content: ContentPinCodeWidget(
                onOtpChange: (value) {},
                onTapSubmit: () {
                  Navigator.of(context).pop();
                  _bloc.add(NavigateToQrDetailsScreenEvent());
                },
                error: false,
              ),
              titleLabel: '',
            );
          } else if (homeState is NavigateToQrDetailsScreenState) {
            Navigator.of(context).pushNamed(Routes.qrDetails);
          } else if (homeState is NavigateToJobDetailsScreenState &&
              _mainSingleton.user.userType == PersonType.technician) {
            Navigator.of(context).pushNamed(Routes.jobDetails);
          } else if (homeState is SearchVisitorState) {
            _searchedVisitors = homeState.visitors;
          } else if (homeState is SearchJobState) {
            _searchedJobs = homeState.jobs;
          }
        },
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, homeState) {
          if (homeState is ShowSkeletonState) {
            return const SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SkeletonHomeWidget(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 30.0),
                  ),
                ],
              ),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    HomeHeaderSection(
                      user: _mainSingleton.user,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        children: [
                          SearchTextFieldWidget(
                            controller: searchTextEditingController,
                            searchText: 'Search',
                            onChange: (value) {
                              if (_mainSingleton.user.userType ==
                                  PersonType.security) {
                                _bloc.add(SearchVisitorEvent(
                                    _visitors, value.trim()));
                              } else if (_mainSingleton.user.userType ==
                                  PersonType.technician) {
                                _bloc.add(SearchJobEvent(_jobs, value.trim()));
                              }
                            },
                            onClear: () {
                              if (_mainSingleton.user.userType ==
                                  PersonType.security) {
                                setState(() {
                                  _searchedVisitors = _visitors;
                                });
                              } else {
                                setState(() {
                                  _searchedJobs = _jobs;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16.0),
                          const CheckInAndOutWidget(),
                          const SizedBox(height: 16.0),
                          _mainSingleton.user.userType == PersonType.security
                              ? SecurityItemsWidget(
                                  visitors: _searchedVisitors,
                                  onTapPinCode:
                                      _openPinCodeBottomSheetForSecurity,
                                )
                              : _mainSingleton.user.userType ==
                                      PersonType.technician
                                  ? TechnicalItemsWidget(
                                      jobs: _searchedJobs,
                                      onTapCard: (job) {
                                        _bloc.add(
                                            NavigateToJobDetailsScreenEvent());
                                      },
                                    )
                                  : const SizedBox.shrink(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void fetchingDataAccordingPersonType(User user) async {
    await Future.delayed(const Duration(seconds: 2));

    if (user.userType == PersonType.security) {
      _fetchAllVisitors();
    } else if (user.userType == PersonType.technician) {
      _fetchAllJobs();
    }
  }

  void _fetchAllVisitors() => _bloc.add(FetchAllVisitorsEvent());

  void _fetchAllJobs() => _bloc.add(FetchAllJobsEvent());

  void _openPinCodeBottomSheetForSecurity() =>
      _bloc.add(ShowPinCodeBottomSheetForSecurityEvent());
}
