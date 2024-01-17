part of 'qr_details_bloc.dart';

abstract class QrDetailsEvent extends Equatable {
  const QrDetailsEvent();

  @override
  List<Object> get props => [
        identityHashCode(this),
      ];
}

final class FetchQrDetailsEvent extends QrDetailsEvent {}

final class NavigateToBackEvent extends QrDetailsEvent {}
