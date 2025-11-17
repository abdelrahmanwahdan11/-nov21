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
      'popular_stays': 'Popular stays',
      'view_all': 'View all',
      'compare': 'Compare',
      'no_favorites': 'No favorites yet',
      'add_more_hotels': 'Start adding hotels you love',
      'ai_info_title': 'AI insights coming soon',
      'ai_info_desc': 'We will surface smart trip tips about this stay here.',
      'reward_options': 'Reward options',
      'points_balance': 'Points balance',
      'upcoming_trips': 'Upcoming trips',
      'past_trips': 'Past trips',
      'no_upcoming': 'No upcoming trips yet',
      'no_history': 'No history yet',
      'my_bookings': 'My bookings',
      'nights': 'nights',
      'guests': 'guests',
      'check_in': 'Check in',
      'check_out': 'Check out',
      'cancel': 'Cancel',
      'checkedIn': 'Checked in',
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'upcoming': 'Upcoming',
      'open_favorites': 'Favorites hub',
      'open_bookings': 'Trips timeline',
      'open_rewards': 'Rewards',
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
      'popular_stays': 'إقامات رائجة',
      'view_all': 'عرض الكل',
      'compare': 'مقارنة',
      'no_favorites': 'لا توجد مفضلة بعد',
      'add_more_hotels': 'ابدأ بإضافة الفنادق التي تعجبك',
      'ai_info_title': 'رؤى الذكاء الاصطناعي قريباً',
      'ai_info_desc': 'سنظهر نصائح سفر ذكية عن هذا الفندق هنا.',
      'reward_options': 'خيارات المكافآت',
      'points_balance': 'رصيد النقاط',
      'upcoming_trips': 'رحلات قادمة',
      'past_trips': 'رحلات سابقة',
      'no_upcoming': 'لا توجد رحلات قادمة',
      'no_history': 'لا يوجد سجل بعد',
      'my_bookings': 'حجوزاتي',
      'nights': 'ليالٍ',
      'guests': 'ضيوف',
      'check_in': 'تسجيل الدخول',
      'check_out': 'تسجيل الخروج',
      'cancel': 'إلغاء',
      'checkedIn': 'تم تسجيل الدخول',
      'completed': 'مكتمل',
      'cancelled': 'ملغى',
      'upcoming': 'قادمة',
      'open_favorites': 'مركز المفضلة',
      'open_bookings': 'خط رحلاتك',
      'open_rewards': 'المكافآت',
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
