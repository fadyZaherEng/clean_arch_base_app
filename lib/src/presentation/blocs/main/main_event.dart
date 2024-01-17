part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class NavigateBetweenScreensForSecurityEvent extends MainEvent {
  final int position;

  NavigateBetweenScreensForSecurityEvent({this.position = 0});
}

final class NavigateBetweenScreensForTechnicianEvent extends MainEvent {
  final int position;

  NavigateBetweenScreensForTechnicianEvent({this.position = 0});
}

final class NavigateToScanQrCodeScreenEvent extends MainEvent {}

final class GetCurrentUserEvent extends MainEvent {}
