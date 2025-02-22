import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(seconds: 5),
      backgroundColor: MyThemeData.backgroundColor,
      splashScreenBody: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: MediaQuery.sizeOf(context).height),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.20),
              child: SizedBox(
                child: Image.asset('assets/images/splash/movies.png'),
              ),
            ),
            const Spacer(),
            SizedBox(
              child: Image.asset('assets/images/splash/brand.png'),
            ),
          ],
        ),
      ),
      onEnd: () => Navigator.popAndPushNamed(context, HomeScreen.routeName),
    );
  }
}
