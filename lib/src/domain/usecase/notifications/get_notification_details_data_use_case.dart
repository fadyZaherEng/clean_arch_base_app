import 'package:city_eye/src/domain/entities/notification/notification_item.dart';

class GetNotificationDetailsDataUseCase {
  NotificationItem call() {
    return TestData().getTestData();
  }
}

class TestData {
  NotificationItem getTestData() {
    return NotificationItem(
        1,
        "Header of notification",
        "2021-03-17T19:14:46.535Z",
        "Body of notification Body of notification Body of notification Body of notification Body of notification Body of notification Body of notification Body of notification Body of notification Body of notification ",
        "high",
        "https://images.pexels.com/photos/281493/pexels-photo-281493.jpeg?cs=srgb&dl=pexels-jerome-dominici-281493.jpg&fm=jpg");
  }
}
