import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/data/sources/local/main_singleton.dart';
import 'package:city_eye/src/presentation/screens/home/home_screen.dart';
import 'package:city_eye/src/presentation/screens/main/widgets/bottom_navigation_bar_widget_for_security.dart';
import 'package:city_eye/src/presentation/screens/main/widgets/bottom_navigation_bar_widget_for_technician.dart';
import 'package:city_eye/src/presentation/screens/main/widgets/floating_action_buttom_widget.dart';
import 'package:city_eye/src/presentation/screens/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/main/main_bloc.dart';

class MainScreen extends BaseStatefulWidget {
  const MainScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  MainBloc get _bloc => BlocProvider.of<MainBloc>(context);

  MainSingleton get _mainSingleton => MainSingleton();

  @override
  void initState() {
    _bloc.add(GetCurrentUserEvent());
    super.initState();
  }

  int currentIndexForSecurity = 0;
  int currentIndexForTechnician = 0;

  Widget getCurrentScreenForSecurity(int position) {
    if (position == 0) {
      return const HomeScreen();
    } else if (position == 1) {
      return const SizedBox.shrink();
    } else {
      return const MoreScreen();
    }
  }

  Widget getCurrentScreenForTechnician(int position) {
    if (position == 0) {
      return const HomeScreen();
    } else {
      return const MoreScreen();
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is SuccessFetchCurrentUserState) {
          _mainSingleton.user = state.user;
          _mainSingleton.isUserFound = true;
        } else if (state is SuccessNavigateBetweenScreensForSecurityState &&
            _mainSingleton.user.userType == PersonType.security) {
          currentIndexForSecurity = state.currentPosition;
        } else if (state is SuccessNavigateBetweenScreensForTechnicianState &&
            _mainSingleton.user.userType == PersonType.technician) {
          currentIndexForTechnician = state.currentPosition;
        } else if (state is NavigateToScanQrCodeScreenState) {
          Navigator.of(context).pushNamed(Routes.qrScan);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset:
              _mainSingleton.user.userType == PersonType.technician
                  ? null
                  : false,
          body: _mainSingleton.isUserFound
              ? _mainSingleton.user.userType == PersonType.security
                  ? getCurrentScreenForSecurity(currentIndexForSecurity)
                  : getCurrentScreenForTechnician(currentIndexForTechnician)
              : const SizedBox.shrink(),
          floatingActionButtonLocation:
              _mainSingleton.user.userType == PersonType.security
                  ? FloatingActionButtonLocation.centerDocked
                  : null,
          floatingActionButton: _mainSingleton.user.userType ==
                  PersonType.security
              ? getFloatingActionButtomWidget(
                  context: context,
                  onPressed: () => _bloc.add(NavigateToScanQrCodeScreenEvent()),
                  backgroundColor: ColorSchemes.primary,
                  iconPath: ImagePaths.scanner,
                )
              : null,
          bottomNavigationBar:
              _mainSingleton.user.userType == PersonType.security
                  ? BottomNavigationBarForSecurityWidget(
                      onTap: (index) {
                        if (index != 1) {
                          _bloc.add(
                            NavigateBetweenScreensForSecurityEvent(
                              position: index,
                            ),
                          );
                        }
                      },
                      currentIndex: currentIndexForSecurity,
                    )
                  : BottomNavigationBarForTechnicianWidget(
                      onTap: (index) {
                        _bloc.add(
                          NavigateBetweenScreensForTechnicianEvent(
                            position: index,
                          ),
                        );
                      },
                      currentIndex: currentIndexForTechnician,
                    ),
        );
      },
    );
  }
}
