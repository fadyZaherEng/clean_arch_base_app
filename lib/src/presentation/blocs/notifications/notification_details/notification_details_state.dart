part of 'notification_details_bloc.dart';

@immutable
abstract class NotificationDetailsState {}

class NotificationDetailsInitial extends NotificationDetailsState {}

class ShowSkeletonState extends NotificationDetailsState {}

class HideSkeletonState extends NotificationDetailsState {}

class BackState extends NotificationDetailsState {}

class GetNotificationDetailsDataState extends NotificationDetailsState {
  final NotificationItem list;

  GetNotificationDetailsDataState(this.list);
}

class SetLocalNotificationDetailsDataState extends NotificationDetailsState {}
