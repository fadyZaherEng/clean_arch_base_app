import 'package:city_eye/src/data/sources/local/main_singleton.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String mobileNumber;
  final String image;
  final PersonType userType;
  final String unitNumber;
  final bool isActive;

  const User({
    this.id = 1,
    this.name = "",
    this.email = "",
    this.password = "",
    this.mobileNumber = "",
    this.image = "",
    this.userType = PersonType.unknown,
    this.unitNumber = "",
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'mobileNumber': mobileNumber,
      'image': image,
      'userType': userType.person,
      'unitNumber': unitNumber,
      'isActive': isActive,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      mobileNumber: map['mobileNumber'] as String,
      image: map['image'] as String,
      userType: (map['userType'] as String) == 'security'
          ? PersonType.security
          : PersonType.technician,
      unitNumber: map['unitNumber'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  User clone() => User(
        id: id,
        name: name,
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        image: image,
        userType: userType,
        isActive: isActive,
        unitNumber: unitNumber,
      );

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, mobileNumber: $mobileNumber, image: $image, userType: $userType, unitNumber: $unitNumber, isActive: $isActive}';
  }
}
