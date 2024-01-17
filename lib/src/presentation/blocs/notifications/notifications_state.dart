part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class ShowSkeletonState extends NotificationsState {}

class NotificationsPopState extends NotificationsState {}

// ignore: must_be_immutable
class NotificationClickActionState extends NotificationsState {
  NotificationItem notificationItem;

  NotificationClickActionState(this.notificationItem);
}

class NotificationsDataState extends NotificationsState {
  final List<NotificationItem> notifications;

  NotificationsDataState({required this.notifications});
}
