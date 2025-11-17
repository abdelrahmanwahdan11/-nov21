import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._prefs);

  final SharedPreferences _prefs;
  static const _keyOnboarding = 'has_seen_onboarding';
  static const _keyLoggedIn = 'is_logged_in';

  bool _hasSeenOnboarding = false;
  bool _isLoggedIn = false;

  bool get hasSeenOnboarding => _hasSeenOnboarding;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> load() async {
    _hasSeenOnboarding = _prefs.getBool(_keyOnboarding) ?? false;
    _isLoggedIn = _prefs.getBool(_keyLoggedIn) ?? false;
    notifyListeners();
  }

  Future<void> markOnboardingSeen() async {
    _hasSeenOnboarding = true;
    await _prefs.setBool(_keyOnboarding, true);
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoggedIn = email.isNotEmpty && password.isNotEmpty;
    await _prefs.setBool(_keyLoggedIn, _isLoggedIn);
    notifyListeners();
    return _isLoggedIn;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await _prefs.setBool(_keyLoggedIn, false);
    notifyListeners();
  }
}
