import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/presentation/screens/home/home_screen.dart';
import 'package:city_eye/src/presentation/screens/more/more_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetUserInformationUseCase _getUserInformationUseCase;

  MainBloc(this._getUserInformationUseCase) : super(ShowSkeletonState()) {
    on<NavigateBetweenScreensForSecurityEvent>(
        _onNavigateBetweenScreensForSecurityEvent);
    on<NavigateBetweenScreensForTechnicianEvent>(
        _onNavigateBetweenScreensForTechnicianEvent);
    on<NavigateToScanQrCodeScreenEvent>(_onNavigateToScanQrCodeScreenEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
  }

  final List<Widget> screens = [const HomeScreen(), const MoreScreen()];

  Future<void> _onNavigateBetweenScreensForSecurityEvent(
      NavigateBetweenScreensForSecurityEvent event,
      Emitter<MainState> emit) async {
    emit(SuccessNavigateBetweenScreensForSecurityState(event.position));
  }

  FutureOr<void> _onNavigateBetweenScreensForTechnicianEvent(
      NavigateBetweenScreensForTechnicianEvent event, Emitter<MainState> emit) {
    emit(SuccessNavigateBetweenScreensForTechnicianState(event.position));
  }

  FutureOr<void> _onNavigateToScanQrCodeScreenEvent(
      NavigateToScanQrCodeScreenEvent event, Emitter<MainState> emit) {
    emit(NavigateToScanQrCodeScreenState());
  }

  Future<void> _onGetCurrentUserEvent(
      GetCurrentUserEvent event, Emitter<MainState> emit) async {
    final user = _getUserInformationUseCase();
    emit(SuccessFetchCurrentUserState(user: user));
  }
}
