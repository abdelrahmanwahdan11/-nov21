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
      'name': 'Name',
      'email': 'Email',
      'phone': 'Phone',
      'login': 'Login',
      'register': 'Create account',
      'email_phone': 'Email or phone',
      'password': 'Password',
      'confirm_password': 'Confirm password',
      'forgot_password': 'Forgot password?',
      'reset_password': 'Reset password',
      'reset_sent': 'We sent a reset code to your inbox.',
      'guest_login': 'Continue as guest',
      'required': 'Required',
      'invalid_email': 'Invalid email',
      'min_chars': 'Min 6 chars',
      'passwords_match': 'Passwords must match',
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
      'load_more': 'Load more',
      'filters_title': 'Filters',
      'max_price': 'Max price',
      'min_rating': 'Min rating',
      'max_distance': 'Max distance',
      'hotel_type': 'Hotel type',
      'sort_price': 'Price (low to high)',
      'sort_rating': 'Rating (high to low)',
      'sort_distance': 'Distance (nearest first)',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark mode',
      'reduce_animations': 'Reduce animations',
      'primary_color': 'Primary color',
      'about': 'About',
      'version': 'Version 1.0',
      'ai_chat_hint': 'Ask Roamify anything…',
      'send': 'Send',
      'rewards_points': 'Club points',
      'see_rewards': 'See reward options',
      'rewards_section': 'Rewards',
      'bookings_section': 'Bookings',
      'milestone_title': 'Milestone to 100 nights',
      'club_member': 'Club member',
      'booking_history': 'Booking history',
      'reward_options': 'Reward options',
      'upcoming': 'Upcoming',
      'past': 'Past',
      'comparison': 'Comparison',
      'remove': 'Remove',
      'book_now': 'Book now',
    },
    'ar': {
      'app_name': 'روميفاي',
      'skip': 'تخطي',
      'next': 'التالي',
      'get_started': 'ابدأ الآن',
      'name': 'الاسم',
      'email': 'البريد الإلكتروني',
      'phone': 'الهاتف',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'email_phone': 'البريد أو الهاتف',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'forgot_password': 'هل نسيت كلمة المرور؟',
      'reset_password': 'إعادة تعيين كلمة المرور',
      'reset_sent': 'تم إرسال رمز التفعيل إلى بريدك.',
      'guest_login': 'الدخول كضيف',
      'required': 'حقل مطلوب',
      'invalid_email': 'بريد غير صالح',
      'min_chars': 'ستة أحرف على الأقل',
      'passwords_match': 'يجب تطابق كلمتي المرور',
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
      'load_more': 'تحميل المزيد',
      'filters_title': 'التصفيات',
      'max_price': 'أعلى سعر',
      'min_rating': 'أدنى تقييم',
      'max_distance': 'أقصى مسافة',
      'hotel_type': 'نوع الفندق',
      'sort_price': 'السعر من الأقل',
      'sort_rating': 'التقييم من الأعلى',
      'sort_distance': 'الأقرب أولاً',
      'language': 'اللغة',
      'theme': 'السمة',
      'dark_mode': 'الوضع الداكن',
      'reduce_animations': 'تقليل الحركات',
      'primary_color': 'اللون الأساسي',
      'about': 'حول التطبيق',
      'version': 'الإصدار 1.0',
      'ai_chat_hint': 'اسأل روميفاي أي شيء...',
      'send': 'إرسال',
      'rewards_points': 'نقاط النادي',
      'see_rewards': 'خيارات المكافآت',
      'rewards_section': 'المكافآت',
      'bookings_section': 'الحجوزات',
      'milestone_title': 'الطريق إلى ١٠٠ ليلة',
      'club_member': 'عضو النادي',
      'booking_history': 'سجل الحجوزات',
      'reward_options': 'خيارات المكافآت',
      'upcoming': 'قادمة',
      'past': 'سابقة',
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
