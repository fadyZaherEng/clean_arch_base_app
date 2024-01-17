part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class MainInitial extends MainState {}
final class ShowSkeletonState extends MainState {}

final class SuccessNavigateBetweenScreensForSecurityState extends MainState {
  final int currentPosition;

  SuccessNavigateBetweenScreensForSecurityState(this.currentPosition);
}

final class SuccessNavigateBetweenScreensForTechnicianState extends MainState {
  final int currentPosition;

  SuccessNavigateBetweenScreensForTechnicianState(this.currentPosition);
}

final class NavigateToScanQrCodeScreenState extends MainState {}

// Get User State
class SuccessFetchCurrentUserState extends MainState {
  final User user;

  SuccessFetchCurrentUserState({
    required this.user,
  });
}

class FailureFetchCurrentUserState extends MainState {}
