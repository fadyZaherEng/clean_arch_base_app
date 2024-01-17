part of 'more_bloc.dart';

abstract class MoreState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class MoreInitial extends MoreState {}

class ShowSkeletonState extends MoreState {}

class ShowLoadingState extends MoreState {}

class HideLoadingState extends MoreState {}

// class GetUserInformationState extends MoreState {
//   final User user;
//
//   GetUserInformationState({
//     required this.user,
//   });
// }

class NavigateToNotificationScreenState extends MoreState {}

class NavigateToChangePasswordScreenState extends MoreState {}

class ShowBottomSheetWidgetState extends MoreState {}

class NavigateBackState extends MoreState {}

class SetLanguageState extends MoreState {
  final String languageCode;

  SetLanguageState({
    required this.languageCode,
  });
}

class GetLanguageState extends MoreState {
  final String languageCode;

  GetLanguageState({
    required this.languageCode,
  });
}

class NavigateToSignInState extends MoreState {}

class SuccessLogoutState extends MoreState {}

class FailureLogoutState extends MoreState {}

class ShowLogoutDialogState extends MoreState {}

class RestartAppWhenLogoutState extends MoreState {}
