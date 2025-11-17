import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._prefs);

  final SharedPreferences _prefs;
  static const _loggedKey = 'logged_in';
  static const _onboardingKey = 'seen_onboarding';

  bool _loggedIn = false;
  bool _seenOnboarding = false;
  User? _currentUser;

  bool get isLoggedIn => _loggedIn;
  bool get hasSeenOnboarding => _seenOnboarding;
  User? get user => _currentUser;

  Future<void> load() async {
    _loggedIn = _prefs.getBool(_loggedKey) ?? false;
    _seenOnboarding = _prefs.getBool(_onboardingKey) ?? false;
    notifyListeners();
  }

  Future<void> markOnboardingSeen() async {
    _seenOnboarding = true;
    await _prefs.setBool(_onboardingKey, true);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _loggedIn = true;
    _currentUser = User(name: 'Roamifier', email: email, phone: '+9715000000');
    await _prefs.setBool(_loggedKey, true);
    notifyListeners();
  }

  Future<void> logout() async {
    _loggedIn = false;
    _currentUser = null;
    await _prefs.setBool(_loggedKey, false);
    notifyListeners();
  }
}
