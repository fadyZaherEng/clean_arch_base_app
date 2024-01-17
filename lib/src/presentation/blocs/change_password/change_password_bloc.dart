import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/utils/validation/change_password_validator.dart';
import 'package:city_eye/src/domain/usecase/change_password/change_password_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<AbstractChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc(
    this._changePasswordUseCase,
  ) : super(ChangePasswordInitialState()) {
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<ValidateOldPasswordEvent>(_onValidateOldPasswordEvent);
    on<ValidateNewPasswordEvent>(_onValidateNewPasswordEvent);
    on<ValidateConfirmPasswordEvent>(_onValidateConfirmPasswordEvent);
    on<NavigationBackEvent>(_onNavigationBackEvent);
  }

  FutureOr<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<ChangePasswordState> emit) {
    final validationsState = _changePasswordUseCase.validateFormUseCase(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == ChangePasswordValidationState.oldPasswordEmpty) {
          emit(OldPasswordEmptyFormatState(
            oldPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element == ChangePasswordValidationState.newPasswordEmpty) {
          emit(NewPasswordEmptyFormatState(
            newPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element ==
            ChangePasswordValidationState.confirmPasswordEmpty) {
          emit(ConfirmPasswordEmptyFormatState(
            confirmPasswordValidatorMessage: S.current.thisFieldIsRequired,
          ));
        } else if (element ==
            ChangePasswordValidationState.confirmPasswordNotMatchNewPassword) {
          emit(ConfirmPasswordNotMatchNewPasswordFormatState(
            confirmPasswordValidatorMessage:
            S.current.passwordDoesntMatch,
          ));
        }
      }
    } else {
      emit(ChangePasswordSuccessState());
    }
  }

  FutureOr<void> _onValidateOldPasswordEvent(
      ValidateOldPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState =
        _changePasswordUseCase.validateOldPassword(
      event.oldPassword,
    );
    if (validationState == ChangePasswordValidationState.valid) {
      emit(OldPasswordFormatValidState());
    } else {
      emit(OldPasswordEmptyFormatState(
        oldPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateNewPasswordEvent(
      ValidateNewPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState =
        _changePasswordUseCase.validateNewPassword(
      event.newPassword,
    );
    if (validationState == ChangePasswordValidationState.valid) {
      emit(NewPasswordFormatValidState());
    } else if (validationState ==
        ChangePasswordValidationState.newPasswordMustBeSixCharacter) {
      emit(NewPasswordMostBeMustBeSixCharacterFormatState(
          newPasswordValidatorMessage:
              S.current.passwordDoesntMatch));
    } else {
      emit(NewPasswordEmptyFormatState(
        newPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidateConfirmPasswordEvent(
      ValidateConfirmPasswordEvent event, Emitter<ChangePasswordState> emit) {
    ChangePasswordValidationState validationState = _changePasswordUseCase
        .validateConfirmPassword(event.newPassword, event.confirmPassword);
    if (validationState == ChangePasswordValidationState.valid) {
      emit(ConfirmPasswordFormatValidState());
    } else if (validationState ==
        ChangePasswordValidationState.confirmPasswordNotMatchNewPassword) {
      emit(ConfirmPasswordNotMatchNewPasswordFormatState(
        confirmPasswordValidatorMessage:
            S.current.passwordDoesntMatch,
      ));
    } else {
      emit(ConfirmPasswordEmptyFormatState(
        confirmPasswordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onNavigationBackEvent(
      NavigationBackEvent event, Emitter<ChangePasswordState> emit) {
    emit(NavigationBackState());
  }
}
