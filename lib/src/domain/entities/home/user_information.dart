import 'package:city_eye/src/data/sources/local/main_singleton.dart';

class UserInformation {
  final String image;
  final String name;
  final PersonType personType;
  final String unitNumber;

  const UserInformation({
    this.image = "",
    this.name = "",
    this.personType = PersonType.unknown,
    this.unitNumber = "",
  });
}
