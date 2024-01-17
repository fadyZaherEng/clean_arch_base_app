import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/screens/main/widgets/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarForSecurityWidget extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const BottomNavigationBarForSecurityWidget({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorSchemes.blackShadow,
            blurRadius: 24.0,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorSchemes.gray,
        selectedItemColor: ColorSchemes.black,
        backgroundColor: ColorSchemes.white,
        selectedLabelStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ColorSchemes.black),
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ColorSchemes.gray),
        elevation: 0.0,
        items: [
          getBottomNavigationBarItemForHomeScreen(context),
          getBottomNavigationBarForScanQrScreen(context),
          getBottomNavigationBarItemForMoreScreen(context),
        ],
      ),
    );
  }
}
