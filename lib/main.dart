import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/app_theme.dart';
import 'package:city_eye/src/core/utils/bloc_observer.dart';
import 'package:city_eye/src/di/injector.dart';
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
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  // Bloc.observer = const SimpleBlocObserver();
  runApp(const RestartWidget(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) => injector()),
        BlocProvider<SignInBloc>(create: (context) => injector()),
        BlocProvider<ForgetPasswordBloc>(create: (context) => injector()),
        BlocProvider<ChangePasswordBloc>(create: (context) => injector()),
        BlocProvider<JobDetailsBloc>(create: (context) => injector()),
        BlocProvider(create: (context) => injector<MainBloc>()),
        BlocProvider(create: (context) => injector<HomeBloc>()),
        BlocProvider(create: (context) => injector<NotificationsBloc>()),
        BlocProvider(create: (context) => injector<NotificationDetailsBloc>()),
        BlocProvider(create: (context) => injector<MoreBloc>()),
        BlocProvider(create: (context) => injector<QrDetailsBloc>()),
        BlocProvider(create: (context) => injector<CommentsBloc>()),
      ],
      child: BlocBuilder<AppCubit, Locale>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splash,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'City Eye',
            theme: AppTheme("en").light, // home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
//AnnotatedRegion<SystemUiOverlayStyle>
/**
 *
    value: const SystemUiOverlayStyle(
    statusBarColor: ColorSchemes.white,
    statusBarIconBrightness: Brightness.dark,
    ),
 * */
