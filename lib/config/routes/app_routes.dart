import 'package:flutter/material.dart';

import '../../core/errors/undefinded_route.dart';
import '../../feature/home/presentation/screens/mobile/mobile_home_screen.dart';

class AppRouteName {
  static const String mobileMainScreen = 'mobileMainScreen';
}

class AppRoute {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.mobileMainScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileHomeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const UnDefinedRoute());
    }
  }
}
