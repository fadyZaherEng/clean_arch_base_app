import 'dart:async';
import 'dart:developer';

import 'package:city_eye/src/data/sources/local/main_singleton.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_is_user_logged_in.dart';
import 'package:city_eye/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_language_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'more_event.dart';

part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final GetUserInformationUseCase _getUserInformationUseCase;
  final SetLanguageUseCase _setLanguageUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final RemoveUserInformationUseCase _removeUserInformationUseCase;
  final RemoveIsUserLoggedInUseCase _removeIsUserLoggedInUseCase;
  final RemoveRememberMeUseCase _removeRememberMeUseCase;

  MoreBloc(
    this._getUserInformationUseCase,
    this._setLanguageUseCase,
    this._getLanguageUseCase,
    this._removeUserInformationUseCase,
    this._removeIsUserLoggedInUseCase,
    this._removeRememberMeUseCase,
  ) : super(ShowSkeletonState()) {
    on<NavigateToNotificationScreenEvent>(_onNavigateToNotificationScreenEvent);
    on<NavigateToChangePasswordScreenEvent>(
        _onNavigateToChangePasswordScreenEvent);
    on<ShowBottomSheetWidgetEvent>(_onShowBottomSheetWidgetEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<GetLanguageEvent>(_onGetLanguageEvent);
    on<SetLanguageEvent>(_onSetLanguageEvent);
    on<NavigateToSignInEvent>(_onNavigateToSignInEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<ShowLogoutDialogEvent>(_onShowLogoutDialogEvent);
    on<RestartAppWhenLogoutEvent>(_onRestartAppWhenLogoutEvent);
  }

  FutureOr<void> _onGetLanguageEvent(
      GetLanguageEvent event, Emitter<MoreState> emit) async {
    emit(ShowSkeletonState());

    await Future.delayed(const Duration(seconds: 2));
    String languageCode = _getLanguageUseCase();
    emit(GetLanguageState(languageCode: languageCode));
  }

  FutureOr<void> _onSetLanguageEvent(
      SetLanguageEvent event, Emitter<MoreState> emit) async {
    await _setLanguageUseCase(event.languageCode);
    emit(SetLanguageState(languageCode: event.languageCode));
  }

  // FutureOr<void> _onGetUserInformationEvent(
  //     GetUserInformationEvent event, Emitter<MoreState> emit) {
  //   User user = _getUserInformationUseCase();
  //   emit(GetUserInformationState(user: user));
  // }

  Future<void> _onNavigateToNotificationScreenEvent(
      NavigateToNotificationScreenEvent event, Emitter<MoreState> emit) async {
    emit(NavigateToNotificationScreenState());
  }

  Future<void> _onShowBottomSheetWidgetEvent(
      ShowBottomSheetWidgetEvent event, Emitter<MoreState> emit) async {
    emit(ShowBottomSheetWidgetState());
  }

  Future<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<MoreState> emit) async {
    emit(NavigateBackState());
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<MoreState> emit) async {
    final isRemovedUser = await _removeUserInformationUseCase();
    final isRemovedRememberMe = await _removeRememberMeUseCase();
    final isRemovedLogIn = await _removeIsUserLoggedInUseCase();
    if (isRemovedUser && isRemovedLogIn && isRemovedRememberMe) {
      MainSingleton().user = const User();
      MainSingleton().isUserFound = false;
      emit(SuccessLogoutState());
    } else if (isRemovedUser && isRemovedLogIn && !isRemovedRememberMe) {
      MainSingleton().user = const User();
      MainSingleton().isUserFound = false;
      emit(SuccessLogoutState());
    }
  }

  FutureOr<void> _onNavigateToSignInEvent(
      NavigateToSignInEvent event, Emitter<MoreState> emit) {
    emit(NavigateToSignInState());
  }

  FutureOr<void> _onShowLogoutDialogEvent(
      ShowLogoutDialogEvent event, Emitter<MoreState> emit) {
    emit(ShowLogoutDialogState());
  }

  FutureOr<void> _onRestartAppWhenLogoutEvent(
      RestartAppWhenLogoutEvent event, Emitter<MoreState> emit) {
    emit(RestartAppWhenLogoutState());
  }

  FutureOr<void> _onNavigateToChangePasswordScreenEvent(
      NavigateToChangePasswordScreenEvent event, Emitter<MoreState> emit) {
    emit(NavigateToChangePasswordScreenState());
  }
}
