import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const supportedLocales = [Locale('en'), Locale('ar')];

  static const _localizedStrings = {
    'en': {
      'app_title': 'Roamify',
      'home': 'Home',
      'search': 'Search',
      'ai': 'AI',
      'rewards': 'Rewards',
      'settings': 'Settings',
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot password?',
      'welcome': 'Plan your next stay',
      'book_now': 'Book now',
      'favorites': 'Favorites',
      'ai_info': 'AI info coming soon',
      'language': 'Language',
      'theme': 'Dark mode',
      'primary_color': 'Primary color',
      'view': 'View',
      'search_hint': 'Search hotels, cities, or tags',
      'filters_title': 'Filters',
      'max_price': 'Max price',
      'min_rating': 'Min rating',
      'max_distance': 'Max distance (km)',
      'hotel_type': 'Hotel type',
      'reset': 'Reset',
      'apply': 'Apply',
      'filters': 'Filters',
      'sort': 'Sort',
      'results': 'Results',
      'load_more': 'Load more',
      'reduce_motion': 'Reduce motion',
    },
    'ar': {
      'app_title': 'روميفاي',
      'home': 'الرئيسية',
      'search': 'بحث',
      'ai': 'الذكاء الاصطناعي',
      'rewards': 'المكافآت',
      'settings': 'الإعدادات',
      'login': 'تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'welcome': 'خطط لإقامتك القادمة',
      'book_now': 'احجز الآن',
      'favorites': 'المفضلة',
      'ai_info': 'معلومات الذكاء الاصطناعي قريباً',
      'language': 'اللغة',
      'theme': 'الوضع الداكن',
      'primary_color': 'اللون الأساسي',
      'view': 'عرض',
      'search_hint': 'ابحث عن الفنادق أو المدن أو الوسوم',
      'filters_title': 'الفلاتر',
      'max_price': 'أقصى سعر',
      'min_rating': 'أدنى تقييم',
      'max_distance': 'أقصى مسافة (كم)',
      'hotel_type': 'نوع الفندق',
      'reset': 'إعادة تعيين',
      'apply': 'تطبيق',
      'filters': 'الفلاتر',
      'sort': 'فرز',
      'results': 'النتائج',
      'load_more': 'تحميل المزيد',
      'reduce_motion': 'تقليل الحركة',
    },
  };

  String translate(String key) => _localizedStrings[locale.languageCode]?[key] ?? key;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
