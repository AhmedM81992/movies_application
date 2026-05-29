import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oktoast/oktoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:secure_application/secure_application.dart';
import 'package:sizer/sizer.dart';

import 'package:movies_app/config/language/codegen_loader.g.dart';
import 'package:movies_app/core/network/check_connectivity/cubit/connectivity_cubit.dart';
import 'package:movies_app/core/network/check_connectivity/presentation/no_internet_screen.dart';
import 'package:movies_app/core/network/local/popular_local_database.dart';
import 'package:movies_app/core/services/injection_container.dart' as get_it;
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/bloc_observer.dart';
import 'package:movies_app/feature/bookmarks/presentation/business_logic/cubit/bookmark_cubit.dart';
import 'package:movies_app/feature/browse/presentation/business_logic/bloc/browse_bloc.dart';
import 'package:movies_app/feature/home/presentation/business_logic/bloc/home_screen_bloc.dart';
import 'package:movies_app/feature/home/presentation/business_logic/bloc/movie_details_bloc.dart';
import 'package:movies_app/feature/home/presentation/business_logic/cubit/bottom_nav_cubit.dart';
import 'package:movies_app/feature/home/presentation/screens/layout/splash_screen.dart';
import 'package:movies_app/feature/home/presentation/screens/mobile/mobile_home_screen.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/sub_items/detailed_container_sub_items/details_videoplayer.dart';
import 'package:movies_app/feature/search/presentation/business_logic/bloc/search_bloc.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/feature/browse/presentation/screens/movies_for_one_category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => {};
  }
  if (kDebugMode) {
    Bloc.observer = MyBlocObserver();
  }

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PopularLocalDatabase.initDatabase();

  FirebaseFirestore.instance.disableNetwork();

  await get_it.init();

  runApp(
    OverlaySupport.global(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'),
        child: const MoviesApp(),
      ),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) {
              final cubit = ConnectivityCubit();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                cubit.checkInternetConnection();
              });
              return cubit;
            },
          ),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return OKToast(
              child: SecureApplication(
                child: Builder(
                  builder: (ctx) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      initialRoute: SplashScreen.routeName,
                      routes: {
                        SplashScreen.routeName: (_) => const SplashScreen(),
                        MobileHomeScreen.routeName: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider<HomeScreenBloc>(
                                  create: (_) => get_it.sl<HomeScreenBloc>(),
                                ),
                                BlocProvider<BookmarkCubit>(
                                  create: (_) => get_it.sl<BookmarkCubit>(),
                                ),
                                BlocProvider<BottomNavCubit>(
                                  create: (_) => get_it.sl<BottomNavCubit>(),
                                ),
                                BlocProvider<SearchBloc>(
                                  create: (_) => get_it.sl<SearchBloc>(),
                                ),
                                BlocProvider<BrowseBloc>(
                                  create: (_) => get_it.sl<BrowseBloc>(),
                                ),
                              ],
                              child: const MobileHomeScreen(),
                            ),
                        DetailsPage.routeName: (_) =>
                            BlocProvider<MovieDetailsBloc>(
                              create: (_) => get_it.sl<MovieDetailsBloc>(),
                              child: const DetailsPage(),
                            ),
                        MoviesForOneCategory.routeName: (_) =>
                            BlocProvider<BrowseBloc>(
                              create: (_) => get_it.sl<BrowseBloc>(),
                              child: const MoviesForOneCategory(),
                            ),
                        DetailsVideoPlayer.routeName: (context) {
                          final String? movieId = ModalRoute.of(context)
                              ?.settings
                              .arguments as String?;
                          return DetailsVideoPlayer(movieId: movieId!);
                        },
                      },
                      theme: ThemeData(
                        primaryColor: AppColors.royalBlue,
                        scaffoldBackgroundColor: AppColors.bgBody,
                        fontFamily: 'Cairo',
                      ),
                      builder: (context, child) {
                        return SecureGate(
                          blurr: 16,
                          opacity: 0.08,
                          child: Stack(
                            children: [
                              child ?? const SizedBox.shrink(),
                              BlocBuilder<ConnectivityCubit, ConnectivityState>(
                                builder: (context, state) {
                                  if (state is DeviceConnectedState &&
                                      !state.isConnected) {
                                    return const NoInternetScreen();
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
