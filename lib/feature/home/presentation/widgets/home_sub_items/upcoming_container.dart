import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/home/presentation/business_logic/bloc/home_screen_bloc.dart';
import 'package:movies_app/feature/home/presentation/business_logic/bloc/home_screen_state.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared/bookmark_container.dart';

import 'details_page.dart';

class UpComingContainer extends StatefulWidget {
  const UpComingContainer({Key? key}) : super(key: key);

  @override
  State<UpComingContainer> createState() => _UpComingContainerState();
}

class _UpComingContainerState extends State<UpComingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.02),
            child: Text(
              'New Releases', // Title
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                if (state.upcomingStatus == LoadStatus.loading) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: MyThemeData.selectedColor));
                }
                if (state.upcomingStatus == LoadStatus.error) {
                  return Center(child: Text("Something Went Wrong!"));
                }
                final moviesList = state.upcomingResults;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.01,
                          right: MediaQuery.sizeOf(context).width * 0.02,
                          left: MediaQuery.sizeOf(context).width * 0.02,
                          bottom: MediaQuery.sizeOf(context).width * 0.02),
                      child: Container(
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailsPage.routeName,
                                  arguments: moviesList[index].id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constants.imageBaseUrl +
                                      (moviesList[index].posterPath ?? ""),
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      color: MyThemeData.selectedColor,
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            MyBookmarkWidget(moviesList: moviesList[index]),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: moviesList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
