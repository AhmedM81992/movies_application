import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/core/shared_widgets/app_bar_widget.dart';
import 'package:movies_app/feature/browse/presentation/business_logic/bloc/browse_bloc.dart';
import 'package:movies_app/feature/browse/presentation/business_logic/bloc/browse_state.dart';
import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';

import 'package:movies_app/feature/browse/presentation/widgets/category_movies_list_items.dart';

class MoviesForOneCategory extends StatefulWidget {
  static const String routeName = "MoviesForOneCategory";
  const MoviesForOneCategory({Key? key}) : super(key: key);

  @override
  State<MoviesForOneCategory> createState() => _MoviesForOneCategoryState();
}

class _MoviesForOneCategoryState extends State<MoviesForOneCategory> {
  @override
  void initState() {
    super.initState();
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final genreId = int.tryParse("${arguments["id"]}") ?? 0;
    context.read<BrowseBloc>().add(GetMovieDiscoverEvent(genreId));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Container(
      color: MyThemeData.backgroundColor,
      child: Column(
        children: [
          AppBarWidget(
            title: "${arguments["name"]}",
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: BlocBuilder<BrowseBloc, BrowseState>(
              builder: (context, state) {
                if (state.discoverStatus == LoadStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyThemeData.selectedColor,
                    ),
                  );
                }
                if (state.discoverStatus == LoadStatus.error) {
                  return const Center(child: Text("Something Went Wrong!"));
                }
                final categoryMoviesList = state.discoverResults;
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
          ),
        ],
      ),
    );
  }
}
