import 'package:flutter/material.dart';
import 'package:movies_app/models/MovieDiscoverModel.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

import 'browse_sub/movies_for _one_category.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16), // Add some vertical spacing
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Category Browse', // Title
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set title text color
              ),
            ),
          ),
          const SizedBox(height: 8), // Add some vertical spacing
          Expanded(
            child: FutureBuilder(
                future: ApiManager.getMoviesList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: MyThemeData.selectedColor,
                    ));
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something Went Wrong!"));
                  }
                  var categoryList = snapshot.data!.genres ?? [];
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Set the number of columns
                      crossAxisSpacing: 8, // Set spacing between columns
                      mainAxisSpacing: 8, // Set spacing between rows
                    ),
                    itemCount: categoryList.length,
                    // Set the itemCount to 0 for an empty grid
                    itemBuilder: (BuildContext context, int index) {
                      // This function won't be called since the itemCount is 0
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MoviesForOneCategory.routeName,
                                arguments: {
                                  "id": categoryList[index].id,
                                  "name": categoryList[index].name
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.sizeOf(context).height / 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/browse/placeholder_image.png",
                                  ),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    MyThemeData.blackColor.withOpacity(0.2),
                                    BlendMode.srcATop,
                                  ),
                                )),
                            child: Text(
                              categoryList[index].name ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white, // Set title text color
                              ),
                            ),
                          ),
                        ),
                      ); // Return an empty container
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
