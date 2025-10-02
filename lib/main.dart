import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/network/remote/dio_helper.dart';
import 'package:movies_app/feature/home/presentation/screens/layout/splash_screen.dart';
import 'package:movies_app/providers/movie_detail_provider.dart';
import 'package:movies_app/providers/my_provider.dart';
import 'package:movies_app/feature/home/presentation/screens/mobile/mobile_home_screen.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/sub_items/detailed_container_sub_items/details_videoplayer.dart';
import 'package:movies_app/core/network/local/popular_local_database.dart';
import 'package:provider/provider.dart';

import 'package:secure_application/secure_application.dart'; // ^4.1.0

import 'core/components/constants.dart';
import 'firebase_options.dart';
import 'screens/tabs/browse_sub/movies_for _one_category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await DioHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PopularLocalDatabase.initDatabase();

  FirebaseFirestore.instance.disableNetwork(); // optional

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // call secure() once when SecureApplication is in the tree
  //   if (Constants.securedOnce) return;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final secure = SecureApplicationProvider.of(context);
  //     secure
  //         ?.secure(); // ANDROID: sets FLAG_SECURE (blocks screenshots/recorders)
  //   });
  //   Constants.securedOnce = true;
  // }

  @override
  Widget build(BuildContext context) {
    return SecureApplication(
      child: Builder(
        builder: (ctx) {
          // Call once when this subtree mounts
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   final secure = SecureApplicationProvider.of(ctx);
          //   secure
          //       ?.secure(); // ANDROID: set FLAG_SECURE -> block screenshots & most recorders
          // });

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // Keep SecureGate *under* MaterialApp to have Directionality
            builder: (context, child) => SecureGate(
              
              blurr: 16,
              opacity: 0.08,
              child: child ?? const SizedBox.shrink(),
            ),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (_) => const SplashScreen(),
              MobileHomeScreen.routeName: (_) => const MobileHomeScreen(),
              DetailsPage.routeName: (_) => const DetailsPage(),
              MoviesForOneCategory.routeName: (_) =>
                  const MoviesForOneCategory(),
              DetailsVideoPlayer.routeName: (context) {
                final String? movieId =
                    ModalRoute.of(context)?.settings.arguments as String?;
                return DetailsVideoPlayer(movieId: movieId!);
              },
            },
          );
        },
      ),
    );
  }
}
