import 'package:flutter/material.dart';
import '../../../models/MovieDiscoverModel.dart';
import '../../../core/network/remote/api_manager.dart';
import '../../../config/theme/my_theme_data.dart';
import 'category_movies-list_items.dart';

class MoviesForOneCategory extends StatelessWidget {
  static const String routeName = "MoviesForOneCategory";
  const MoviesForOneCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          "${arguments["name"]}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ApiManager.getMovieDiscover("${arguments["id"]}"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    color: MyThemeData.selectedColor));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something Went Wrong!"));
          }
          var categoryMoviesList = snapshot.data!.results ?? [];
          return ListView.builder(
            itemCount: categoryMoviesList.length,
            itemBuilder: (context, index) {
              Results results = categoryMoviesList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: categoryMoviesListItem(
                  result: results,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
