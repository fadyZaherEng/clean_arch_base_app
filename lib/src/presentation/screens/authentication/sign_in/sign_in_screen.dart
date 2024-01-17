import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/sign_in_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends BaseStatefulWidget {
  const SignInScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen> {
  SignInBloc get _bloc => BlocProvider.of<SignInBloc>(context);

  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isCheckRememberMe = false;
  String? _mobileNumberErrorMessage;
  String? _passwordErrorMessage;

  @override
  void initState() {
    _bloc.add(GetRememberMeEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is SignInSuccessState) {
          _navigateToHomeScreen();
        } else if (state is SignInErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            onTap: () {
              Navigator.pop(context);
            },
          );
        } else if (state is ChangeRememberMeValueState) {
          _isCheckRememberMe = state.rememberMeValue;
        } else if (state is NavigateToForgotPasswordScreenEvent) {
          _navigateToForgotPasswordScreen();
        } else if (state is MobileNumberEmptyFormatState) {
          _mobileNumberErrorMessage = state.mobileNumberValidatorMessage;
        } else if (state is MobileNumberFormatValidState) {
          _mobileNumberErrorMessage = null;
        } else if (state is PasswordEmptyFormatState) {
          _passwordErrorMessage = state.passwordValidatorMessage;
        } else if (state is PasswordFormatValidState) {
          _passwordErrorMessage = null;
        } else if (state is GetRememberMeState) {
          _isCheckRememberMe = state.rememberMe;
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            _bloc.add(ChangeRememberMeValueEvent(
              rememberMeValue: false,
            ));
            return Future.value(true);
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SignInContentWidget(
              mobileNumberController: _mobileNumberController,
              passwordController: _passwordController,
              isCheckRememberMe: _isCheckRememberMe,
              phoneNumberErrorMessage: _mobileNumberErrorMessage,
              passwordErrorMessage: _passwordErrorMessage,
              validationMobileNumberAction: (String value) {
                _bloc.add(ValidateMobileNumberEvent(
                  mobileNumber: value,
                ));
              },
              validationPasswordAction: (String value) {
                _bloc.add(ValidatePasswordEvent(
                  password: value,
                ));
              },
              rememberMeAction: (bool value) {
                _bloc.add(ChangeRememberMeValueEvent(
                  rememberMeValue: value,
                ));
              },
              forgetPasswordAction: () {
                _bloc.add(NavigateToForgotPasswordScreenState());
              },
              signInAction: () {
                _bloc.add(
                  SignInEvent(
                    mobileNumber: _mobileNumberController.text,
                    password: _passwordController.text,
                  ),
                );
              },
              onCloseAction: () {
                _bloc.add(
                  ChangeRememberMeValueEvent(
                    rememberMeValue: false,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _navigateToHomeScreen() {
    Navigator.pushNamed(context, Routes.main);
  }

  void _showMessageDialog({
    required String message,
    required Function() onTap,
  }) {
    showMessageDialogWidget(
      context: context,
      text: message,
      icon: ImagePaths.frame,
      buttonText: S.of(context).ok,
      onTap: () {
        onTap();
      },
    );
  }

  void _navigateToForgotPasswordScreen() {
    Navigator.pushNamed(
      context,
      Routes.forgetPassword,
    );
  }
}
