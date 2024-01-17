part of 'sign_in_bloc.dart';

@immutable
abstract class AbstractSignInEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class SignInEvent extends AbstractSignInEvent {
  final String mobileNumber;
  final String password;

  SignInEvent({
    required this.mobileNumber,
    required this.password,
  });
}

class ChangeRememberMeValueEvent extends AbstractSignInEvent {
  final bool rememberMeValue;

  ChangeRememberMeValueEvent({
    required this.rememberMeValue,
  });
}

class NavigateToForgotPasswordScreenState extends AbstractSignInEvent {}

class ValidateMobileNumberEvent extends AbstractSignInEvent {
  final String mobileNumber;

  ValidateMobileNumberEvent({
    required this.mobileNumber,
  });
}

class ValidatePasswordEvent extends AbstractSignInEvent {
  final String password;

  ValidatePasswordEvent({
    required this.password,
  });
}

class GetRememberMeEvent extends AbstractSignInEvent {}

