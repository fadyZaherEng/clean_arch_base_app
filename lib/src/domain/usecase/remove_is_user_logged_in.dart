import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveIsUserLoggedInUseCase {
  final SharedPreferences sharedPreferences;

  RemoveIsUserLoggedInUseCase(this.sharedPreferences);

  Future<bool> call() async {
    return await sharedPreferences.remove(SharedPreferenceKeys.isLoggedIn);
  }
}
