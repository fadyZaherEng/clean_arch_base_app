import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_eye/src/domain/entities/home/job.dart';
import 'package:city_eye/src/domain/entities/home/visitor.dart';
import 'package:city_eye/src/presentation/screens/home/utils/home_enum.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final GetUserInformationUseCase _getUserInformationUseCase;

  HomeBloc() : super(ShowSkeletonState()) {
    on<FetchAllVisitorsEvent>(_onGetAllVisitorsEvent);
    on<FetchAllJobsEvent>(_onFetchAllJobsEvent);
    on<ShowPinCodeBottomSheetForSecurityEvent>(
        _onShowPinCodeBottomSheetForSecurityEvent);
    on<ShowPinCodeBottomSheetForTechnicalEvent>(
        _onShowPinCodeBottomSheetForTechnicalEvent);
    on<NavigateToQrDetailsScreenEvent>(_onNavigateToQrDetailsScreenEvent);
    on<NavigateToJobDetailsScreenEvent>(_onNavigateToJobDetailsScreenEvent);
    on<SearchVisitorEvent>(_onSearchVisitorEvent);
    on<SearchJobEvent>(_onSearchJobEvent);
    on<ShowSkeletonEvent>(_onShowSkeletonEvent);

    // on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
  }

  final List<VisitorEntity> _visitors = [
    VisitorEntity(
      visitorType: VisitorType.single,
      date: 'Monday',
      status: StatusVisitor.completed,
      statusColor: StatusColor.success,
      time: DateTime.now().toString(),
      owner: 'Afify',
      visitor: 'Abaza',
      unit: '10',
    ),
    VisitorEntity(
      visitorType: VisitorType.single,
      date: 'Monday',
      status: StatusVisitor.completed,
      statusColor: StatusColor.success,
      time: DateTime.now().toString(),
      owner: 'Hassan',
      visitor: 'Amr',
      unit: '10',
    ),
    VisitorEntity(
      visitorType: VisitorType.multi,
      date: 'Monday',
      status: StatusVisitor.completed,
      statusColor: StatusColor.success,
      time: DateTime.now().toString(),
      owner: 'Afify',
      visitor: 'Amr',
      validDate: DateTime.now().toString(),
      unit: '15',
    ),
  ];

  final List<JobEntity> _jobs = [
    JobEntity(
      id: '#75777676',
      unit: 'V/10',
      date: DateTime.now().toString(),
      status: StatusJob.completed,
    ),
    JobEntity(
      id: '#88875777676',
      unit: 'V/15',
      date: DateTime.now().toString(),
      status: StatusJob.completed,
    ),
  ];

  Future<void> _onGetAllVisitorsEvent(
      FetchAllVisitorsEvent event, Emitter<HomeState> emit) async {
    emit(SuccessFetchAllVisitorsState(visitors: _visitors));
  }

  Future<void> _onFetchAllJobsEvent(
      FetchAllJobsEvent event, Emitter<HomeState> emit) async {
    emit(SuccessFetchAllJobsState(jobs: _jobs));
  }

  Future<void> _onShowPinCodeBottomSheetForSecurityEvent(
      ShowPinCodeBottomSheetForSecurityEvent event,
      Emitter<HomeState> emit) async {
    emit(ShowBottomSheetWidgetForSecurityState());
  }

  Future<void> _onShowPinCodeBottomSheetForTechnicalEvent(
      ShowPinCodeBottomSheetForTechnicalEvent event,
      Emitter<HomeState> emit) async {
    emit(ShowBottomSheetWidgetForTechnicalState());
  }

  // Future<void> _onGetCurrentUserEvent(
  //     GetCurrentUserEvent event, Emitter<HomeState> emit) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final user = _getUserInformationUseCase();
  //   emit(SuccessFetchCurrentUserState(user: user));
  // }

  FutureOr<void> _onNavigateToQrDetailsScreenEvent(
      NavigateToQrDetailsScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToQrDetailsScreenState());
  }

  FutureOr<void> _onNavigateToJobDetailsScreenEvent(
      NavigateToJobDetailsScreenEvent event, Emitter<HomeState> emit) {
    emit(NavigateToJobDetailsScreenState());
  }

  FutureOr<void> _onSearchVisitorEvent(
      SearchVisitorEvent event, Emitter<HomeState> emit) {
    if (event.owner.isNotEmpty) {
      final List<VisitorEntity> searchedVisitors = event.visitors
          .where((visitor) => visitor.owner.contains(event.owner))
          .toList();
      emit(SearchVisitorState(searchedVisitors));
    } else {
      emit(SearchVisitorState(_visitors));
    }
  }

  FutureOr<void> _onSearchJobEvent(
      SearchJobEvent event, Emitter<HomeState> emit) {
    if (event.id.isNotEmpty) {
      final List<JobEntity> searchedVisitors =
          event.jobs.where((job) => job.id.contains(event.id)).toList();
      emit(SearchJobState(searchedVisitors));
    } else {
      emit(SearchJobState(_jobs));
    }
  }

  FutureOr<void> _onShowSkeletonEvent(
      ShowSkeletonEvent event, Emitter<HomeState> emit) {
    emit(ShowSkeletonState());
  }
}
