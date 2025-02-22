import 'package:flutter/material.dart';
import 'package:movies_app/models/ResultsModel.dart';
import 'package:movies_app/screens/tabs/search_sub_items/search_list_items.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

import '../../models/SearchModel.dart';

class SearchTab extends StatefulWidget {
  SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Results>? searchResults = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff514F4F),
                ),
                child: TextField(
                  controller: searchController,
                  cursorColor: MyThemeData.selectedColor,
                  style: TextStyle(color: MyThemeData.whiteColor),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white38),
                    prefixIcon:
                        Icon(Icons.search, color: MyThemeData.whiteColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: MyThemeData.whiteColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: MyThemeData.whiteColor,
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      searchMovies(text);
                    } else {
                      setState(() {
                        searchResults!.clear();
                      });
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: searchResults != null
                  ? searchResults!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/novideo.png"),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: searchResults!.length,
                          itemBuilder: (context, index) {
                            return SearchListItems(
                                result: searchResults![index]);
                          },
                        )
                  : Center(
                      child: CircularProgressIndicator(
                          color: MyThemeData.selectedColor),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchMovies(String query) async {
    if (query.isNotEmpty) {
      try {
        // Calls the API to get search results
        SearchModel? searchModel = await ApiManager.getSearch(query);
        if (searchModel != null) {
          setState(() {
            searchResults = searchModel.results;
          });
          print("Search Results: ${searchResults?.length}");
          print("Query: $query");
        }
      } catch (e) {
        print("Error searching movies: $e");
      }
    }
  }
}
