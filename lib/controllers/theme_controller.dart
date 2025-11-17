import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs);

  final SharedPreferences _prefs;
  static const _darkKey = 'is_dark_mode';
  static const _primaryKey = 'primary_color_hex';

  bool _isDark = false;
  Color _primaryColor = const Color(0xFF4F6F52);

  bool get isDark => _isDark;
  Color get primaryColor => _primaryColor;

  ThemeMode get mode => _isDark ? ThemeMode.dark : ThemeMode.light;

  Future<void> load() async {
    _isDark = _prefs.getBool(_darkKey) ?? false;
    final hex = _prefs.getInt(_primaryKey);
    if (hex != null) {
      _primaryColor = Color(hex);
    }
    notifyListeners();
  }

  Future<void> toggleDark() async {
    _isDark = !_isDark;
    await _prefs.setBool(_darkKey, _isDark);
    notifyListeners();
  }

  Future<void> updatePrimary(Color color) async {
    _primaryColor = color;
    await _prefs.setInt(_primaryKey, color.value);
    notifyListeners();
  }
}
