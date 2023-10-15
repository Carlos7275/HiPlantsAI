import 'package:shared_preferences/shared_preferences.dart';

class LocalPersistance {
  late final SharedPreferences _prefs;
  final String _jwtKey = "";

  static final LocalPersistance instance =
      LocalPersistance._privateConstructor();

  LocalPersistance._privateConstructor() {
    init();
  }

  init() async => _prefs = await SharedPreferences.getInstance();

  _save(String key, Object? value) {
    if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    }
  }

  T? _get<T>(String key) {
    T? val;
    if (T == int) {
      val = _prefs.getInt(key) as T;
    } else if (T is String) {
      val = _prefs.getString(key) as T;
    } else if (T is bool) {
      val = _prefs.getBool(key) as T;
    } else if (T is double) {
      val = _prefs.getDouble(key) as T;
    }
    return val;
  }

  set jwt(String? jwt) => _save(_jwtKey, jwt);
  String? get jwt => _get<String>(_jwtKey);
}
