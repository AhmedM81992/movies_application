import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/feature/home/presentation/screens/layout/splash_screen.dart';
import 'package:movies_app/providers/movie_detail_provider.dart';
import 'package:movies_app/providers/my_provider.dart';
import 'package:movies_app/feature/home/presentation/screens/mobile/mobile_home_screen.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/sub_items/detailed_container_sub_items/details_videoplayer.dart';
import 'package:movies_app/core/network/local/popular_local_database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/tabs/browse_sub/movies_for _one_category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize LocalDatabase
  await PopularLocalDatabase.initDatabase();
  FirebaseFirestore.instance.disableNetwork();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => MovieDetailsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MobileHomeScreen.routeName: (context) => const MobileHomeScreen(),
        DetailsPage.routeName: (context) => const DetailsPage(),
        MoviesForOneCategory.routeName: (context) =>
            const MoviesForOneCategory(),
        DetailsVideoPlayer.routeName: (context) {
          // Extract the movieId argument from the route settings
          final String? movieId =
              ModalRoute.of(context)?.settings.arguments as String?;
          // Return the DetailsVideoPlayer widget with the provided movieId
          return DetailsVideoPlayer(movieId: movieId!);
        },
      },
    );
  }
}
