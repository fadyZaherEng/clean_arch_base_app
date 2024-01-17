import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/data/sources/local/main_singleton.dart';
import 'package:city_eye/src/domain/entities/more/language.dart';
import 'package:city_eye/src/presentation/blocs/more/more_bloc.dart';
import 'package:city_eye/src/presentation/screens/more/utils/show_language_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_header_widget.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_item_divider.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  MoreBloc get _bloc => BlocProvider.of<MoreBloc>(context);

  MainSingleton get _mainSingleton => MainSingleton();

  List<Language> languages = [
    const Language(id: 1, name: "English", image: "", code: "en"),
    const Language(id: 2, name: "Arabic", image: "", code: "ar"),
    const Language(id: 3, name: "French", image: "", code: "fr"),
  ];
  Language selectedLanguage = const Language(
    id: -1,
    name: "",
    image: "",
    code: "",
  );

  @override
  void initState() {
    super.initState();
    _bloc.add(GetLanguageEvent());
  }

  bool isActiveNotification = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoreBloc, MoreState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
        } else if (state is HideLoadingState) {
        } else if (state is NavigateToNotificationScreenState) {
          Navigator.pushNamed(context, Routes.notifications);
        } else if (state is NavigateToChangePasswordScreenState) {
          Navigator.pushNamed(context, Routes.changePassword);
        } else if (state is ShowBottomSheetWidgetState) {
          _displayBottomSheet(
            context: context,
            languages: languages,
          );
        } else if (state is NavigateBackState) {
          Navigator.of(context).pop();
        } else if (state is SetLanguageState) {
          RestartWidget.restartApp(context);
        } else if (state is GetLanguageState) {
          selectedLanguage = selectedLanguage.copyWith(
            code: state.languageCode,
          );
        } else if (state is ShowLogoutDialogState) {
          showActionDialogWidget(
            context: context,
            icon: ImagePaths.frame,
            secondaryAction: _logout,
            secondaryText: 'Yes',
            primaryAction: () => Navigator.of(context).pop(),
            primaryText: 'No',
            text: 'you wanna logout ?',
          );
        } else if (state is SuccessLogoutState) {
          _navigateToSignIn();
        } else if (state is NavigateToSignInState) {
          _bloc.add(RestartAppWhenLogoutEvent());
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil(Routes.login, (route) => false);
        } else if (state is RestartAppWhenLogoutState) {
          RestartWidget.restartApp(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              MoreHeaderWidget(
                user: _mainSingleton.user,
                onTapSwitchAction: () {},
                onTapSelectCompound: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              MoreItemWidget(
                title: S.of(context).language,
                imagePath: ImagePaths.language,
                onTap: _openBottomSheet,
              ),
              const MoreItemDivider(),
              MoreItemWidget(
                isSwitchIcon: true,
                count: 7,
                isCounterWidget: true,
                valueOfSwitch: isActiveNotification,
                onToggleSwitch: (value) {
                  setState(
                    () => isActiveNotification = value,
                  );
                },
                title: S.of(context).notifications,
                imagePath: ImagePaths.secondNotification,
                onTap: () => _navigateToNotificationScreen(),
              ),
              const MoreItemDivider(),
              MoreItemWidget(
                title: S.of(context).changePassword,
                imagePath: ImagePaths.icLock,
                onTap: () => _bloc.add(NavigateToChangePasswordScreenEvent()),
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: _showLogoutDialog,
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[200]!,
                  ),
                ),
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.redError,
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _logout() => _bloc.add(LogoutEvent());

  void _showLogoutDialog() => _bloc.add(ShowLogoutDialogEvent());

  void _navigateToSignIn() => _bloc.add(NavigateToSignInEvent());

  void _displayBottomSheet({
    required BuildContext context,
    required List<Language> languages,
  }) =>
      showLanguageBottomSheet(
        context: context,
        height: 400,
        languages: languages,
        selectedLanguage: selectedLanguage,
        onLanguageSelected: (language) {
          _navigateBackEvent();
          if (language.code == selectedLanguage.code) return;
          selectedLanguage = language;
          _bloc.add(
            SetLanguageEvent(
              languageCode: selectedLanguage.code,
            ),
          );
          //_navigateBackEvent();
        },
      );

  void _navigateToNotificationScreen() =>
      _bloc.add(NavigateToNotificationScreenEvent());

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _openBottomSheet() {
    _bloc.add(ShowBottomSheetWidgetEvent());
  }
}
