part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class ShowSkeletonEvent extends HomeEvent {}

final class FetchAllVisitorsEvent extends HomeEvent {}

final class FetchAllJobsEvent extends HomeEvent {}

// final class GetCurrentUserEvent extends HomeEvent {}

final class ShowPinCodeBottomSheetForSecurityEvent extends HomeEvent {}

final class ShowPinCodeBottomSheetForTechnicalEvent extends HomeEvent {}

final class NavigateToQrDetailsScreenEvent extends HomeEvent {}

final class NavigateToJobDetailsScreenEvent extends HomeEvent {}

final class SearchVisitorEvent extends HomeEvent {
  final List<VisitorEntity> visitors;
  final String owner;

  SearchVisitorEvent(this.visitors, this.owner);
}

final class SearchJobEvent extends HomeEvent {
  final List<JobEntity> jobs;
  final String id;

  SearchJobEvent(this.jobs, this.id);
}
