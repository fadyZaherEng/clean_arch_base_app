part of 'job_details_bloc.dart';

@immutable
abstract class JobDetailsEvent {}

class BackEvent extends JobDetailsEvent {}

class GetJobsDetailsDataEvent extends JobDetailsEvent {}

class OnBottomReceiveClickEvent extends JobDetailsEvent {}

class OnBottomStartJobClickEvent extends JobDetailsEvent {}

class OnBottomCompleteClickEvent extends JobDetailsEvent {}

class OnBottomMoreClickEvent extends JobDetailsEvent {}

class ActionWidgetClickedEvent extends JobDetailsEvent {}
