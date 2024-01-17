import 'package:city_eye/src/domain/entities/comment/order.dart';
import 'package:city_eye/src/presentation/screens/comment/comments_screen.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/presentation/screens/job_details/job_details_screen.dart';
import 'package:city_eye/src/presentation/screens/main/main_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_details_screen/notifications_details_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/notifications_screen.dart';
import 'package:city_eye/src/presentation/screens/qr/scan/qr_scan_screen.dart';
import 'package:city_eye/src/domain/entities/album_images/images_album.dart';
import 'package:city_eye/src/presentation/screens/album_images_screen/album_images_screen.dart';
import 'package:city_eye/src/presentation/screens/qr_details/qr_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:city_eye/src/presentation/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:city_eye/src/presentation/screens/change_password/change_password_screen.dart';
import 'package:city_eye/src/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String forgetPassword = "/forgetPassword";
  static const String main = "/main";
  static const String jobDetails = "/jobDetials";
  static const String albumImages = "/albumImages";
  static const String qrScan = "/qrScan";
  static const String more = '/more';
  static const String notifications = "/notifications";
  static const String notificationDetails = "/notificationDetails";
  static const String qrDetails = "/history_details";
  static const String changePassword = "/changePassword";
  static const String comments = '/comment';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.qrDetails:
        return _materialRoute(
          const QrDetailsScreen(),

        );
      case Routes.splash:
        return _materialRoute(const SplashScreen());
      case Routes.login:
        return _materialRoute(const SignInScreen());
      case Routes.forgetPassword:
        return _materialRoute(const ForgetPasswordScreen());
      case Routes.main:
        return _materialRoute(
          const MainScreen(),
        );
      case Routes.jobDetails:
        return _materialRoute(const JobDetailsScreen(title: ''));
      case Routes.comments:
        Order order = const Order();
        return _materialRoute(
          CommentsScreen(order: order),
        );
      case Routes.albumImages:
        ImagesAlbum imagesAlbum = routeSettings.arguments as ImagesAlbum;
        return _materialRoute(AlbumImageScreen(
          imagesAlbum: imagesAlbum,
        ));
      case Routes.qrScan:
        return _materialRoute(
          const QrCodeScanScreen(),
        );
      case Routes.notifications:
        return _materialRoute(
          const NotificationsScreen(),
        );
      case Routes.notificationDetails:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          NotificationDetailsScreen(
              isPushedNotification: arg["isPushedNotification"] as bool,
              notificationDetails: arg["details"] as NotificationItem),
        );
      case Routes.changePassword:
        return _materialRoute(const ChangePasswordScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: const Center(
          child: Text("Not found"),
        ),
      ),
    );
  }
}
