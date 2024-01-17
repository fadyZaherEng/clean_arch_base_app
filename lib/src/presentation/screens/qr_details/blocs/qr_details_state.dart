part of 'qr_details_bloc.dart';

abstract class QrDetailsState extends Equatable {
  const QrDetailsState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class HistoryDetailsInitial extends QrDetailsState {}

class ShowingSkeletonQrDetailsState extends QrDetailsState {}

class FetchQrDetailsState extends QrDetailsState {}

class NavigateToBackState extends QrDetailsState {}
