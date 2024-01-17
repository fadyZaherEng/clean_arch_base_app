import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

BottomNavigationBarItem getBottomNavigationBarItemForHomeScreen(
    BuildContext context) {
  return _item(
    label: S.of(context).home,
    iconSelected: ImagePaths.coloredHome,
    iconUnSelected: ImagePaths.home,
    context: context,
  );
}

BottomNavigationBarItem getBottomNavigationBarForScanQrScreen(
    BuildContext context) {
  return BottomNavigationBarItem(
    label: S.of(context).scan,
    icon: Container(
      padding: const EdgeInsets.only(top: 30.0),
      color: ColorSchemes.white,
    ),
  );
}

BottomNavigationBarItem getBottomNavigationBarItemForMoreScreen(
    BuildContext context) {
  return _item(
    label: S.of(context).more,
    iconSelected: ImagePaths.coloredMore,
    iconUnSelected: ImagePaths.more,
    context: context,
  );
}

BottomNavigationBarItem _item({
  required String label,
  required String iconSelected,
  required String iconUnSelected,
  required BuildContext context,
}) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.all(4),
      child: SvgPicture.asset(iconUnSelected),
    ),
    label: label,
    activeIcon: Padding(
      padding: const EdgeInsets.all(4),
      child: SvgPicture.asset(iconSelected),
    ),
  );
}
