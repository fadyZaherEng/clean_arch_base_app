import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/utils/validation/sign_in_validator.dart';
import 'package:city_eye/src/data/sources/local/main_singleton.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_is_user_logged_in.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/sign_in_validation_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<AbstractSignInEvent, SignInState> {
  final GetRememberMeUseCase _getRememberMeUseCase;
  final SetRememberMeUseCase _setRememberMeUseCase;
  final SetIsUserLoggedInUseCase _setIsUserLoggedInUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;

  User user = const User(
    id: 1,
    name: "Mohamed Abaza",
    email: "mohamed.abaza3296@gmail.com",
    isActive: true,
    userType: PersonType.technician,
    unitNumber: "10",
    mobileNumber: "0123456789",
    image:
        "https://plus.unsplash.com/premium_photo-1680404114169-e254afa55a16?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1964&q=80",
    password: "123456",
  );
  User otherUser = const User(
    id: 2,
    name: "Mohamed Afify",
    email: "mohamedafify@gmail.com",
    isActive: true,
    userType: PersonType.security,
    unitNumber: "9",
    mobileNumber: "01007847748",
    image:
        "https://plus.unsplash.com/premium_photo-1680404114169-e254afa55a16?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1964&q=80",
    password: "123456",
  );
  final SignInValidationUseCase _signInValidationUseCase;

  SignInBloc(
    this._signInValidationUseCase,
    this._setRememberMeUseCase,
    this._getRememberMeUseCase,
    this._setIsUserLoggedInUseCase,
    this._saveUserInformationUseCase,
  ) : super(SignInInitialState()) {
    on<SignInEvent>(_onSignInEvent);
    on<ChangeRememberMeValueEvent>(_onChangeRememberMeValueEvent);
    on<NavigateToForgotPasswordScreenState>(_onForgetPasswordEvent);
    on<ValidateMobileNumberEvent>(_onValidateUsernameEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<GetRememberMeEvent>(_onGetRememberMeEvent);
  }

  FutureOr<void> _onSignInEvent(SignInEvent event, Emitter<SignInState> emit) {
    final validationsState = _signInValidationUseCase.validateFormUseCase(
      mobileNumber: event.mobileNumber,
      password: event.password,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == SignInValidationState.mobileNumberEmpty) {
          emit(MobileNumberEmptyFormatState(
            mobileNumberValidatorMessage: S.current.mobileNumberCantBeEmpty,
          ));
        } else if (element == SignInValidationState.passwordEmpty) {
          emit(PasswordEmptyFormatState(
            passwordValidatorMessage: S.current.passwordCantBeEmpty,
          ));
        }
      }
    } else if (event.mobileNumber == user.mobileNumber &&
        event.password == user.password) {
      _setIsUserLoggedInUseCase(true);
      _saveUserInformationUseCase(user);
      emit(SignInSuccessState());
    } else if (event.mobileNumber == otherUser.mobileNumber &&
        event.password == otherUser.password) {
      _setIsUserLoggedInUseCase(true);
      _saveUserInformationUseCase(otherUser);
      emit(SignInSuccessState());
    } else {
      emit(SignInErrorState(
        errorMessage: S.current.pleaseEnterAValidMobileNumberAndPassword,
      ));
    }
  }

  FutureOr<void> _onChangeRememberMeValueEvent(
      ChangeRememberMeValueEvent event, Emitter<SignInState> emit) {
    _setRememberMeUseCase.call(event.rememberMeValue);
    emit(ChangeRememberMeValueState(
      rememberMeValue: event.rememberMeValue,
    ));
  }

  FutureOr<void> _onForgetPasswordEvent(
      NavigateToForgotPasswordScreenState event, Emitter<SignInState> emit) {
    emit(NavigateToForgotPasswordScreenEvent());
  }

  FutureOr<void> _onValidateUsernameEvent(
      ValidateMobileNumberEvent event, Emitter<SignInState> emit) {
    SignInValidationState validationState =
        _signInValidationUseCase.validateMobileNumber(
      event.mobileNumber,
    );
    if (validationState == SignInValidationState.valid) {
      emit(MobileNumberFormatValidState());
    } else {
      emit(MobileNumberEmptyFormatState(
        mobileNumberValidatorMessage: S.current.mobileNumberCantBeEmpty,
      ));
    }
  }

  FutureOr<void> _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<SignInState> emit) {
    SignInValidationState validationState =
        _signInValidationUseCase.validatePassword(
      event.password,
    );
    if (validationState == SignInValidationState.valid) {
      emit(PasswordFormatValidState());
    } else {
      emit(PasswordEmptyFormatState(
        passwordValidatorMessage: S.current.passwordCantBeEmpty,
      ));
    }
  }

  FutureOr<void> _onGetRememberMeEvent(
      GetRememberMeEvent event, Emitter<SignInState> emit) async {
    emit(GetRememberMeState(rememberMe: await _getRememberMeUseCase()));
  }
}
