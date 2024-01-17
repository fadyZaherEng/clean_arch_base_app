import 'package:city_eye/src/domain/entities/sign_in/user.dart';

final class MainSingleton {
  MainSingleton._();

  static final MainSingleton _instance = MainSingleton._();

  factory MainSingleton() => _instance;
  User user = const User();
  bool isUserFound = false;
}

enum PersonType {
  technician('technician'),
  security('security'),
  unknown('unknown');

  final String person;

  const PersonType(this.person);
}
