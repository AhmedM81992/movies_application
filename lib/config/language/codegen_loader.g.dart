import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future<Map<String, dynamic>>.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    'welcome': 'مرحباً',
    'home': 'الصفحة الرئيسية',
    'search': 'بحث',
    'settings': 'الإعدادات',
    'profile': 'الملف الشخصي',
    'movies': 'أفلام',
    'watchTrailer': 'مشاهدة الإعلان',
    'details': 'التفاصيل',
    'rating': 'التقييم',
    'noResults': 'لم يتم العثور على نتائج',
    'tryAgain': 'حاول مرة أخرى',
    'language': 'اللغة',
    'darkMode': 'الوضع الداكن',
    'lightMode': 'الوضع الفاتح',
    'logout': 'تسجيل الخروج',
    'login': 'تسجيل الدخول',
    'signUp': 'إنشاء حساب',
    'favorites': 'المفضلة',
    'addToFavorites': 'إضافة إلى المفضلة',
    'removeFromFavorites': 'إزالة من المفضلة',
    'error': 'خطأ',
    'networkError': 'خطأ في الشبكة',
    'retry': 'إعادة المحاولة',
    'password': 'كلمة المرور',
    'username': 'اسم المستخدم',
    'email': 'البريد الإلكتروني',
    'confirmPassword': 'تأكيد كلمة المرور',
    'submit': 'إرسال',
    'back': 'رجوع',
    'next': 'التالي',
    'previous': 'السابق',
    'contactUs': 'اتصل بنا',
    'termsOfService': 'شروط الخدمة',
    'privacyPolicy': 'سياسة الخصوصية',
    'notifications': 'الإشعارات',
    'languageSettings': 'إعدادات اللغة',
    'aboutUs': 'معلومات عنا',
    'help': 'مساعدة',
    'viewAll': 'عرض الكل',
    'topRated': 'الأعلى تقييماً',
    'newReleases': 'الإصدارات الجديدة',
    'loading': 'جاري التحميل',
    'success': 'نجاح',
    'saveChanges': 'حفظ التغييرات',
    'cancel': 'إلغاء',
    'apply': 'تطبيق',
    'close': 'إغلاق'
  };

  static const Map<String, dynamic> en = {
    'welcome': 'Welcome',
    'home': 'Home',
    'search': 'Search',
    'settings': 'Settings',
    'profile': 'Profile',
    'movies': 'Movies',
    'watchTrailer': 'Watch Trailer',
    'details': 'Details',
    'rating': 'Rating',
    'noResults': 'No results found',
    'tryAgain': 'Try again',
    'language': 'Language',
    'darkMode': 'Dark Mode',
    'lightMode': 'Light Mode',
    'logout': 'Logout',
    'login': 'Login',
    'signUp': 'Sign Up',
    'favorites': 'Favorites',
    'addToFavorites': 'Add to Favorites',
    'removeFromFavorites': 'Remove from Favorites',
    'error': 'Error',
    'networkError': 'Network Error',
    'retry': 'Retry',
    'password': 'Password',
    'username': 'Username',
    'email': 'Email',
    'confirmPassword': 'Confirm Password',
    'submit': 'Submit',
    'back': 'Back',
    'next': 'Next',
    'previous': 'Previous',
    'contactUs': 'Contact Us',
    'termsOfService': 'Terms of Service',
    'privacyPolicy': 'Privacy Policy',
    'notifications': 'Notifications',
    'languageSettings': 'Language Settings',
    'aboutUs': 'About Us',
    'help': 'Help',
    'viewAll': 'View All',
    'topRated': 'Top Rated',
    'newReleases': 'New Releases',
    'loading': 'Loading',
    'success': 'Success',
    'saveChanges': 'Save Changes',
    'cancel': 'Cancel',
    'apply': 'Apply',
    'close': 'Close'
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    'ar': ar,
    'en': en,
  };
}
