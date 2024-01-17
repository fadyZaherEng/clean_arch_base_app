part of 'job_details_bloc.dart';

@immutable
abstract class JobDetailsState {}

class JobDetailsInitial extends JobDetailsState {}

class BackState extends JobDetailsState {}

class ShowSkeletonState extends JobDetailsState {}

class GetJobsDetailsSuccessState extends JobDetailsState {}

class GetJobsDetailsFailedState extends JobDetailsState {}

class OnBottomReceiveSuccessState extends JobDetailsState {
  final String message;

  OnBottomReceiveSuccessState({required this.message});
}

class OnBottomReceiveFailedState extends JobDetailsState {
  final String message;

  OnBottomReceiveFailedState({required this.message});
}

class OnBottomStartJobSuccessState extends JobDetailsState {
  final String message;

  OnBottomStartJobSuccessState({required this.message});
}

class OnBottomStartJobFailedState extends JobDetailsState {
  final String message;

  OnBottomStartJobFailedState({required this.message});
}

class OnBottomCompleteSuccessState extends JobDetailsState {
  final String message;

  OnBottomCompleteSuccessState({required this.message});
}

class OnBottomCompleteFailedState extends JobDetailsState {
  final String message;

  OnBottomCompleteFailedState({required this.message});
}

class OnBottomMoreSuccessState extends JobDetailsState {
  final String message;

  OnBottomMoreSuccessState({required this.message});
}

class OnBottomMoreFailedState extends JobDetailsState {
  final String message;

  OnBottomMoreFailedState({required this.message});
}

class ActionWidgetClickedState extends JobDetailsState {}
