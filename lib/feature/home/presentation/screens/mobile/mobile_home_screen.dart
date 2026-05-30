import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/config/language/local_key.g.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared_widgets/app_bar_widget.dart';
import 'package:movies_app/feature/home/presentation/business_logic/bloc/home_screen_bloc.dart';
import 'package:movies_app/feature/home/presentation/business_logic/cubit/bottom_nav_cubit.dart';
import 'package:movies_app/feature/home/presentation/screens/mobile/mobile_home_tab.dart';
import 'package:movies_app/feature/browse/presentation/screens/browse_tab.dart';
import 'package:movies_app/feature/search/presentation/screens/search_tab.dart';
import 'package:movies_app/feature/bookmarks/presentation/screens/watch_list_tab.dart';

class MobileHomeScreen extends StatefulWidget {
  static const String routeName = "Home";
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  final List<Widget> _tabs = [
    const MobileHomeTab(),
    SearchTab(),
    const BrowseTab(),
    WatchListTab(),
  ];

  @override
  void initState() {
    super.initState();
    // Trigger all movie list fetches on init
    context.read<HomeScreenBloc>().add(GetHomePopularEvent());
    context.read<HomeScreenBloc>().add(GetHomeUpcomingEvent());
    context.read<HomeScreenBloc>().add(GetHomeTopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.primaryColor,
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return Column(
            children: [
              state.currentIndex != 0
                  ? SizedBox.shrink()
                  : const AppBarWidget(title: 'Movies'),
              Expanded(
                child: BlocBuilder<BottomNavCubit, BottomNavState>(
                  builder: (context, state) {
                    return Container(
                      child: _tabs[state.currentIndex],
                    );
                  },
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: MediaQuery.sizeOf(context).height * 0.0748,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                  child: BlocBuilder<BottomNavCubit, BottomNavState>(
                    builder: (context, state) {
                      return BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: MyThemeData.primaryColor,
                        onTap: (value) {
                          context.read<BottomNavCubit>().changeTab(value);
                        },
                        iconSize: 20,
                        selectedFontSize: 10,
                        unselectedFontSize: 10,
                        currentIndex: state.currentIndex,
                        selectedItemColor: MyThemeData.selectedColor,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        unselectedItemColor: MyThemeData.whiteColor,
                        selectedIconTheme: const IconThemeData(
                            color: MyThemeData.selectedColor),
                        items: [
                          BottomNavigationBarItem(
                              icon: const Icon(Icons.house),
                              label: LocalKeys.home.tr()),
                          BottomNavigationBarItem(
                              icon: const Icon(Icons.search),
                              label: LocalKeys.search.tr()),
                          BottomNavigationBarItem(
                              icon: const Icon(Icons.movie),
                              label: LocalKeys.browse.tr()),
                          BottomNavigationBarItem(
                              icon: const Icon(Icons.book),
                              label: LocalKeys.watchlist.tr()),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
