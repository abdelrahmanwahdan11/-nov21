import 'dart:async';

import 'package:flutter/material.dart';

/// Simple localization approach backed by in-memory maps.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('ar')];

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'app_name': 'Roamify',
      'skip': 'Skip',
      'next': 'Next',
      'get_started': 'Get started',
      'login': 'Login',
      'register': 'Create account',
      'email_phone': 'Email or phone',
      'password': 'Password',
      'forgot_password': 'Forgot password?',
      'guest_login': 'Continue as guest',
      'home': 'Home',
      'search': 'Search',
      'ai': 'AI',
      'rewards': 'Rewards',
      'settings': 'Settings',
      'ai_info': 'AI info coming soon. Expect curated insights and data-backed travel nudges here.',
      'compare': 'Compare',
      'filters': 'Filters',
      'sort': 'Sort',
      'catalog': 'Catalog',
      'apply': 'Apply',
      'reset': 'Reset',
      'price': 'Price',
      'rating': 'Rating',
      'distance': 'Distance',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark mode',
      'primary_color': 'Primary color',
      'about': 'About',
      'version': 'Version 1.0',
      'ai_chat_hint': 'Ask Roamify anything…',
      'send': 'Send',
      'rewards_points': 'Club points',
      'see_rewards': 'See reward options',
      'comparison': 'Comparison',
      'remove': 'Remove',
      'book_now': 'Book now',
    },
    'ar': {
      'app_name': 'روميفاي',
      'skip': 'تخطي',
      'next': 'التالي',
      'get_started': 'ابدأ الآن',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'email_phone': 'البريد أو الهاتف',
      'password': 'كلمة المرور',
      'forgot_password': 'هل نسيت كلمة المرور؟',
      'guest_login': 'الدخول كضيف',
      'home': 'الرئيسية',
      'search': 'بحث',
      'ai': 'ذكاء',
      'rewards': 'المكافآت',
      'settings': 'الإعدادات',
      'ai_info': 'سيتم عرض رؤى الذكاء الاصطناعي هنا قريباً.',
      'compare': 'قارن',
      'filters': 'تصفيات',
      'sort': 'فرز',
      'catalog': 'فئات',
      'apply': 'تطبيق',
      'reset': 'إعادة ضبط',
      'price': 'السعر',
      'rating': 'التقييم',
      'distance': 'المسافة',
      'language': 'اللغة',
      'theme': 'السمة',
      'dark_mode': 'الوضع الداكن',
      'primary_color': 'اللون الأساسي',
      'about': 'حول التطبيق',
      'version': 'الإصدار 1.0',
      'ai_chat_hint': 'اسأل روميفاي أي شيء...',
      'send': 'إرسال',
      'rewards_points': 'نقاط النادي',
      'see_rewards': 'خيارات المكافآت',
      'comparison': 'المقارنة',
      'remove': 'إزالة',
      'book_now': 'احجز الآن',
    },
  };

  String translate(String key) =>
      _localizedValues[locale.languageCode]?[key] ?? key;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.contains(Locale(locale.languageCode));

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
