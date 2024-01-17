import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _poweredByAnimation;
  bool isUserLoggedIn = false;
  bool _isRememberMe = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(
        0.0,
        0.5,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _poweredByAnimation = Tween<Offset>(
      begin: const Offset(
        0.0,
        1,
      ),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    isUserLoggedIn = (await SharedPreferences.getInstance())
        .getBool(SharedPreferenceKeys.isLoggedIn) ??
        false;
    _isRememberMe = (await SharedPreferences.getInstance())
        .getBool(SharedPreferenceKeys.rememberMe) ??
        false;

    if (isUserLoggedIn && _isRememberMe) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
              (route) => false,
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
              (route) => false,
        );
      });
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorSchemes.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Image.asset(
                      ImagePaths.splashLogo,
                    ),
                  ),
                ),
                Container(
                  color: ColorSchemes.iconBackGround,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        S.of(context).stayConnectedStaySmarter,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorSchemes.black,
                          fontWeight: Constants.fontWeightMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 102,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 150,
              right: 0,
              left: 0,
              child: SlideTransition(
                position: _poweredByAnimation,
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    S.of(context).poweredBy,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: ColorSchemes.gray,
                      letterSpacing: -0.24,
                    ),
                  ),
                  Text(
                    S.of(context).cityEye,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                    ),
                  )
                ]),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SvgPicture.asset(
                    width: MediaQuery.sizeOf(context).width,
                    ImagePaths.splashBackground,
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
