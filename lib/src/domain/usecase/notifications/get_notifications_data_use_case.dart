import 'package:city_eye/src/domain/entities/notification/notification_item.dart';

class GetNotificationsDataUseCase {
  List<NotificationItem> call() {
    return TestData().getTestData();
  }
}

class TestData {
  List<NotificationItem> getTestData() {
    return [
      NotificationItem(
          1,
          "Header of notification",
          "2023-08-17T19:14:46.535Z",
          "Body of notification",
          "High",
          "https://images.pexels.com/photos/281493/pexels-photo-281493.jpeg?cs=srgb&dl=pexels-jerome-dominici-281493.jpg&fm=jpg"),
      NotificationItem(
          2,
          "Header of notification Header of notification",
          "2023-05-02T19:14:46.535Z",
          "Body of notification",
          "Medium",
          "https://images.pexels.com/photos/281493/pexels-photo-281493.jpeg?cs=srgb&dl=pexels-jerome-dominici-281493.jpg&fm=jpg"),
      NotificationItem(
          3,
          "Header of notification",
          "2021-03-17T19:14:46.535Z",
          "Body of notification Body of notification Bodnotification Bodnotification Body of notification Body of notification Body of notification Body of notification ",
          "Low",
          "https://images.pexels.com/photos/281493/pexels-photo-281493.jpeg?cs=srgb&dl=pexels-jerome-dominici-281493.jpg&fm=jpg")
    ];
  }
}
