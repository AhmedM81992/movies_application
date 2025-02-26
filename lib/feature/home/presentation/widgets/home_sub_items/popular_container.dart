import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/network/local/fetch_api.dart'; // Import LocalDatabase
import 'package:movies_app/core/shared/bookmark_container.dart';

import '../../../../../config/theme/my_theme_data.dart';

class PopularContainer extends StatefulWidget {
  const PopularContainer({super.key});

  @override
  State<PopularContainer> createState() => _PopularContainerState();
}

class _PopularContainerState extends State<PopularContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      width: MediaQuery.sizeOf(context).width,
      child: FutureBuilder(
        future: FetchAPI.getPopular(), // Use FetchAPI to fetch data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(color: MyThemeData.selectedColor),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong!"),
            );
          }
          var moviesList = snapshot.data?.results ?? [];
          return PageView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.235,
                          child: CachedNetworkImage(
                            imageUrl: Constants.imageBaseUrl +
                                (moviesList[index].backdropPath ?? ""),
                            fit: BoxFit.fitWidth,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        color: MyThemeData.selectedColor,
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await FetchAPI.getdetails(
                                  moviesList[index].id.toString());
                            },
                            child: IconButton(
                              onPressed: () {
                                String movieId =
                                    moviesList[index].id.toString();

                                Navigator.pushNamed(
                                    context, DetailsPage.routeName,
                                    arguments: movieId);
                              },
                              icon: Icon(
                                CupertinoIcons.play_circle_fill,
                                color: Colors.white,
                                size: MediaQuery.sizeOf(context).width * 0.24,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height * 0.1,
                              left: MediaQuery.sizeOf(context).width * 0.05),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await FetchAPI.getdetails(
                                        moviesList[index].id.toString());
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, DetailsPage.routeName,
                                          arguments: moviesList[index].id);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: Constants.imageBaseUrl +
                                            (moviesList[index].posterPath ??
                                                ""),
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: MyThemeData
                                                            .selectedColor,
                                                        value: downloadProgress
                                                            .progress)),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                MyBookmarkWidget(
                                  moviesList: moviesList[index],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.sizeOf(context).width * 0.37,
                            top: MediaQuery.sizeOf(context).height * 0.24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moviesList[index].originalTitle ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.sizeOf(context).width *
                                        0.035,
                                    fontWeight: FontWeight.w400),
                                maxLines: 1,
                              ),
                              Text(
                                moviesList[index].releaseDate ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.sizeOf(context).width *
                                        0.021,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: moviesList.length,
          );
        },
      ),
    );
  }
}
