import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs);

  final SharedPreferences _prefs;
  static const _keyLocale = 'locale';
  static const _keyReduceMotion = 'reduce_motion';

  Locale _locale = const Locale('en');
  bool _reduceMotion = false;

  Locale get locale => _locale;
  bool get reduceMotion => _reduceMotion;

  Future<void> load() async {
    final code = _prefs.getString(_keyLocale);
    _locale = code == null ? const Locale('en') : Locale(code);
    _reduceMotion = _prefs.getBool(_keyReduceMotion) ?? false;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _prefs.setString(_keyLocale, locale.languageCode);
    notifyListeners();
  }

  Future<void> toggleReduceMotion(bool value) async {
    _reduceMotion = value;
    await _prefs.setBool(_keyReduceMotion, value);
    notifyListeners();
  }
}
