import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/home/user_information.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:flutter/material.dart';

class UserInformationWidget extends StatelessWidget {
  final User user;

  const UserInformationWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorSchemes.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              user.image,
              fit: BoxFit.fill,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      ImagePaths.profilePlaceHolder,
                      fit: BoxFit.fill,
                    ));
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            Text(
              S.of(context).welcome,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
            ),
            const SizedBox(
              width: 2.5,
            ),
            Text(
              user.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
