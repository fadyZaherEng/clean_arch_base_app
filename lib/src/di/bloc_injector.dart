import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/presentation/blocs/app/app_cubit.dart';
import 'package:city_eye/src/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/comment/comments_bloc.dart';
import 'package:city_eye/src/presentation/blocs/forget_password/forget_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/home/home_bloc.dart';
import 'package:city_eye/src/presentation/blocs/job_details/job_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/main/main_bloc.dart';
import 'package:city_eye/src/presentation/blocs/more/more_bloc.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notification_details/notification_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:city_eye/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr_details/blocs/qr_details_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<AppCubit>(() => AppCubit(
        injector(),
        injector(),
      ));

  injector.registerFactory<SignInBloc>(() => SignInBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(
        injector(),
      ));

  injector.registerFactory<JobDetailsBloc>(() => JobDetailsBloc());
  injector.registerFactory<MainBloc>(
      () => MainBloc(injector<GetUserInformationUseCase>()));
  injector.registerFactory<HomeBloc>(() => HomeBloc());

  injector.registerFactory<MoreBloc>(
    () => MoreBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<NotificationsBloc>(
    () => NotificationsBloc(
      injector(),
    ),
  );

  injector.registerFactory<NotificationDetailsBloc>(
    () => NotificationDetailsBloc(
      injector(),
    ),
  );

  injector.registerFactory<QrDetailsBloc>(
    () => QrDetailsBloc(),
  );
  injector.registerFactory<CommentsBloc>(
    () => CommentsBloc(),
  );

  injector.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc(
        injector(),
      ));
}
