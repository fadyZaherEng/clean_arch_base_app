part of 'notification_details_bloc.dart';

@immutable
abstract class NotificationDetailsEvent {}

class BackEvent extends NotificationDetailsEvent {}

class ShowSkeletonEvent extends NotificationDetailsEvent {}

class HideSkeletonEvent extends NotificationDetailsEvent {}

class GetNotificationDetailsDataEvent extends NotificationDetailsEvent {}

class SetLocalNotificationDetailsDataEvent extends NotificationDetailsEvent {}
