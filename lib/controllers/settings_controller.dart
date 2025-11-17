import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs);

  final SharedPreferences _prefs;
  static const _localeKey = 'app_locale';
  static const _reduceMotionKey = 'reduce_motion';

  Locale _locale = const Locale('en');
  bool _reduceMotion = false;

  Locale get locale => _locale;
  bool get reduceMotion => _reduceMotion;

  Future<void> load() async {
    final code = _prefs.getString(_localeKey);
    if (code != null) {
      _locale = Locale(code);
    }
    _reduceMotion = _prefs.getBool(_reduceMotionKey) ?? false;
    notifyListeners();
  }

  Future<void> updateLocale(Locale locale) async {
    _locale = locale;
    await _prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  Future<void> toggleMotion() async {
    _reduceMotion = !_reduceMotion;
    await _prefs.setBool(_reduceMotionKey, _reduceMotion);
    notifyListeners();
  }
}
