import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static const String registration = "smsKey";
  late SharedPreferences preferences;

  setRegistration() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(registration, true);
  }

  resetRegistration() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(registration, false);
  }

  Future<bool> isRegistered() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(registration) ?? false;
  }
}