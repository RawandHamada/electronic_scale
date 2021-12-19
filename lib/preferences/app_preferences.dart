import 'package:electronic_scale/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  late SharedPreferences _sharedPreferences;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

 Future<void> save({required Users user}) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setString('email', user.email);
    await _sharedPreferences.setString('name', user.name);
    await _sharedPreferences.setString('nameBranch', user.nameBranch);
    //await _sharedPreferences.setString('isActive', user.isActive);
  }

  Users get user {
    return Users(
      name: _sharedPreferences.getString('name') ?? '',
      email: _sharedPreferences.getString('email') ?? '',
      password: _sharedPreferences.getString('password') ??'',
      uid: _sharedPreferences.getString('uid') ??'',
     // isActive: _sharedPreferences.getString('isActive') ??'',
      nameBranch: _sharedPreferences.getString('nameBranch') ??'',
    );
  }
  String get language => _sharedPreferences.getString('language') ?? 'en';

  Future<void> setLanguage(String newLanguageCode) async {
    await _sharedPreferences.setString('language', newLanguageCode);
  }
  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<bool> logout() async {
    // return await _sharedPreferences.remove('key');
    return await _sharedPreferences.clear();
  }

}
