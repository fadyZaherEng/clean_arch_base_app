part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {}

class GetNotificationsDataEvent extends NotificationsEvent {}

class NotificationsPopEvent extends NotificationsEvent {}

// ignore: must_be_immutable
class NotificationClickActionEvent extends NotificationsEvent {
  NotificationItem notificationItem;

  NotificationClickActionEvent(this.notificationItem);
}
