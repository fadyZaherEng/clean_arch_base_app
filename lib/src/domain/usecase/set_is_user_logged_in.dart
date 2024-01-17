import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetIsUserLoggedInUseCase {
  final SharedPreferences sharedPreferences;

  SetIsUserLoggedInUseCase(this.sharedPreferences);

  Future<bool> call(bool value) async {
    return await sharedPreferences.setBool(SharedPreferenceKeys.isLoggedIn, value);
  }
}