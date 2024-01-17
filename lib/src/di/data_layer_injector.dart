import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.dart';


Future<void> initializeDataDependencies() async {

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
