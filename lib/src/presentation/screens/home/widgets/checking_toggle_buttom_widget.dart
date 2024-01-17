import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/color_schemes.dart';
import '../../../../core/resources/image_paths.dart';
import '../../../widgets/custom_button_widget.dart';

class CheckingToggleButtonWidget extends StatelessWidget {
  final Function() onPressCheckIn;
  final Function() onPressCheckOut;

  const CheckingToggleButtonWidget({
    super.key,
    required this.onPressCheckIn,
    required this.onPressCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.primaryWithOpacity,
                  blurRadius: 24.0,
                  offset: Offset(0, 4),
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: CustomButtonWidget(
              onTap: onPressCheckIn,
              text: 'Check in',
              isPrefixIcon: true,
              prefixIcon: SvgPicture.asset(ImagePaths.firstCheckIn),
            ),
          ),
        ),
        const SizedBox(
          width: 13.0,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.redErrorWithOpacity,
                  blurRadius: 24.0,
                  offset: Offset(0, 4),
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: CustomButtonWidget(
              backgroundColor: ColorSchemes.red,
              onTap: onPressCheckOut,
              text: 'Check out',
              isPrefixIcon: true,
              prefixIcon: SvgPicture.asset(ImagePaths.firstCheckOut),
            ),
          ),
        ),
      ],
    );
  }
}
