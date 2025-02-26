import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/network/remote/api_manager.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared/bookmark_container.dart';

class DetailedContainerList extends StatefulWidget {
  const DetailedContainerList({super.key});

  @override
  State<DetailedContainerList> createState() => _DetailedContainerListState();
}

class _DetailedContainerListState extends State<DetailedContainerList> {
  String? movieId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    movieId = arguments is int ? arguments.toString() : arguments as String;
  }

  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Like This', // Title
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          FutureBuilder(
            future: ApiManager.getSimilar(movieId!),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.23,
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
                                            0.175),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: Container(
                                        color: Color(0xFF343534),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
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
