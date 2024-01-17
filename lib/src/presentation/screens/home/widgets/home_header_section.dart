import 'package:city_eye/src/domain/entities/home/user_information.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/user_information_widget.dart';
import 'package:flutter/cupertino.dart';

class HomeHeaderSection extends StatelessWidget {
  final User user;

  const HomeHeaderSection({
    Key? key,
    this.user = const User(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: UserInformationWidget(user: user),
    );
  }
}
