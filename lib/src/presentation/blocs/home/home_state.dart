part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [
        identityHashCode(this),
      ];
}

class HomeInitial extends HomeState {}

class ShowSkeletonState extends HomeState {}

// Get All Visitors States
class SuccessFetchAllVisitorsState extends HomeState {
  final List<VisitorEntity> visitors;

  SuccessFetchAllVisitorsState({
    required this.visitors,
  });
}

class FailureFetchAllVisitorsState extends HomeState {}

// Get All Jobs States
class SuccessFetchAllJobsState extends HomeState {
  final List<JobEntity> jobs;

  SuccessFetchAllJobsState({
    required this.jobs,
  });
}

class FailureFetchAllJobsState extends HomeState {}

class ShowBottomSheetWidgetForSecurityState extends HomeState {}

class ShowBottomSheetWidgetForTechnicalState extends HomeState {}

class NavigateToQrDetailsScreenState extends HomeState {}

class NavigateToJobDetailsScreenState extends HomeState {}

class SearchVisitorState extends HomeState {
  final List<VisitorEntity> visitors;

  SearchVisitorState(this.visitors);
}

class SearchJobState extends HomeState {
  final List<JobEntity> jobs;

  SearchJobState(this.jobs);
}
// // Get User State
// class SuccessFetchCurrentUserState extends HomeState {
//   final User user;
//
//   SuccessFetchCurrentUserState({
//     required this.user,
//   });
// }
//
// class FailureFetchCurrentUserState extends HomeState {}
