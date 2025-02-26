import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/popular_container.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/top_rated_container.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/upcoming_container.dart';

class MobileHomeTab extends StatefulWidget {
  const MobileHomeTab({super.key});

  @override
  State<MobileHomeTab> createState() => _MobileHomeTabState();
}

class _MobileHomeTabState extends State<MobileHomeTab> {
  //String baseUrl = "https://image.tmdb.org/t/p/w500";
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const PopularContainer(),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.010),
      const UpComingContainer(),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.010),
      const TopRatedContainer(),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.010),
    ]);
  }
}
