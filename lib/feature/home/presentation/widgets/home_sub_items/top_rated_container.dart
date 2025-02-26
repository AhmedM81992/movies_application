import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/network/local/fetch_api.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared/bookmark_container.dart';

class TopRatedContainer extends StatefulWidget {
  const TopRatedContainer({super.key});

  @override
  State<TopRatedContainer> createState() => _TopRatedContainerState();
}

class _TopRatedContainerState extends State<TopRatedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.02),
            child: Text(
              'Recommended', // Title
              style: TextStyle(
                  fontSize: MediaQuery.sizeOf(context).width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          FutureBuilder(
            future: FetchAPI.getToprated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: MyThemeData.selectedColor));
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something Went Wrong!"));
              }
              var moviesList = snapshot.data?.results ?? [];
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.01,
                          right: MediaQuery.sizeOf(context).width * 0.02,
                          left: MediaQuery.sizeOf(context).width * 0.02),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.235,
                              width: MediaQuery.sizeOf(context).width * 0.25,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, DetailsPage.routeName,
                                          arguments: moviesList[index].id);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
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
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  MyBookmarkWidget(
                                      moviesList: moviesList[index]),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.sizeOf(context).height *
                                            0.174),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: Container(
                                        color: Color(0xFF343534),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.25,
                                        height:
                                            MediaQuery.sizeOf(context).height,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color: Color(0xFFFFBB3B),
                                                ),
                                                Text(
                                                  moviesList[index]
                                                          .voteAverage
                                                          ?.toStringAsFixed(
                                                              1) ??
                                                      "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              maxLines: 1,
                                              moviesList[index].title ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  moviesList[index]
                                                          .releaseDate ??
                                                      "",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: moviesList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
