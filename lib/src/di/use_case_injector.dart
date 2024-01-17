import 'package:city_eye/src/domain/usecase/change_password/change_password_use_case.dart';
import 'package:city_eye/src/domain/usecase/forget_password/forget_password_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notification_details_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notifications_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_is_user_logged_in.dart';
import 'package:city_eye/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_is_user_logged_in.dart';
import 'package:city_eye/src/domain/usecase/set_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/sign_in_validation_use_case.dart';
import 'injector.dart';

Future<void> initializeUseCaseDependencies() async {
  injector.registerFactory<SetLanguageUseCase>(
      () => SetLanguageUseCase(injector()));

  injector.registerFactory<GetLanguageUseCase>(
      () => GetLanguageUseCase(injector()));

  injector.registerFactory<GetNotificationsDataUseCase>(
      () => GetNotificationsDataUseCase());

  injector.registerFactory<GetNotificationDetailsDataUseCase>(
      () => GetNotificationDetailsDataUseCase());
  injector.registerFactory<GetUserInformationUseCase>(
      () => GetUserInformationUseCase(injector()));
  injector.registerFactory<RemoveUserInformationUseCase>(
      () => RemoveUserInformationUseCase(injector()));
  injector.registerFactory<RemoveIsUserLoggedInUseCase>(
      () => RemoveIsUserLoggedInUseCase(injector()));
  injector.registerFactory<RemoveRememberMeUseCase>(
      () => RemoveRememberMeUseCase(injector()));

  injector
      .registerFactory<ChangePasswordUseCase>(() => ChangePasswordUseCase());

  injector.registerFactory<SignInValidationUseCase>(
    () => SignInValidationUseCase(),
  );
  injector.registerFactory<GetRememberMeUseCase>(() => GetRememberMeUseCase(
        injector(),
      ));

  injector.registerFactory<SetRememberMeUseCase>(() => SetRememberMeUseCase(
        injector(),
      ));

  injector
      .registerFactory<SetIsUserLoggedInUseCase>(() => SetIsUserLoggedInUseCase(
            injector(),
          ));

  injector.registerFactory<SaveUserInformationUseCase>(
      () => SaveUserInformationUseCase(
            injector(),
          ));

  injector.registerFactory<ForgetPasswordValidationUseCase>(
      () => ForgetPasswordValidationUseCase());
}
