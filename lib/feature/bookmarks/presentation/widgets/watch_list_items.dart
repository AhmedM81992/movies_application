import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';
import 'package:movies_app/feature/home/presentation/widgets/home_sub_items/details_page.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared_widgets/app_text.dart';
import 'package:movies_app/core/shared/bookmark_container.dart';

extension BookmarkMovieEntityToResults on BookmarkMovieEntity {
  Results toResults() => Results(
        fireBaseId: fireBaseId,
        id: id,
        title: title,
        backdropPath: backdropPath,
        posterPath: posterPath,
        releaseDate: releaseDate,
        voteAverage: voteAverage,
      );
}

class WatchListItems extends StatelessWidget {
  final BookmarkMovieEntity entity;

  const WatchListItems({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      height: MediaQuery.sizeOf(context).height * 0.14,
      child: Column(
        children: [
          Row(
            children: [
              Stack(children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, DetailsPage.routeName,
                        arguments: entity.id);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.485,
                      height: MediaQuery.of(context).size.height * 0.118,
                      child: CachedNetworkImage(
                        imageUrl: Constants.imageBaseUrl +
                            (entity.backdropPath ?? ""),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                MyBookmarkWidget(moviesList: entity.toResults()),
              ]),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.476,
                height: MediaQuery.sizeOf(context).height * 0.118,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        entity.title ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      AppText(
                        entity.releaseDate ?? "",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Color(0xFFFFBB3B),
                          ),
                          AppText(
                            entity.voteAverage?.toStringAsFixed(1) ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Divider(
            color: MyThemeData.searchBox,
            endIndent: 10,
            indent: 10,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
