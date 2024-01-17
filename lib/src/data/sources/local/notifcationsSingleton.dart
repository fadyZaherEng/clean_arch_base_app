import '../../../domain/entities/notification/notification_item.dart';

final class NotificationsSingleton {
  NotificationsSingleton._();

  static final NotificationsSingleton _instance = NotificationsSingleton._();

  factory NotificationsSingleton() => _instance;

  List<NotificationItem> notifications = [];
}
