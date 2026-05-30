import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/shared_widgets/app_bar_widget.dart';
import 'package:movies_app/feature/search/presentation/widgets/search_list_items.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/search/presentation/business_logic/bloc/search_bloc.dart';
import 'package:movies_app/feature/search/presentation/business_logic/bloc/search_state.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.primaryColor,
      child: Column(
        children: [
          const AppBarWidget(title: 'Search'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff514F4F),
                      ),
                      child: TextField(
                        controller: searchController,
                        cursorColor: MyThemeData.selectedColor,
                        style: TextStyle(color: MyThemeData.whiteColor),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.white38),
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
                          context
                              .read<SearchBloc>()
                              .add(SearchQueryChanged(text));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state.status == LoadStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyThemeData.selectedColor,
                            ),
                          );
                        }
                        if (state.status == LoadStatus.error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/novideo.png"),
                              ],
                            ),
                          );
                        }
                        if (state.results.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/novideo.png"),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.results.length,
                          itemBuilder: (context, index) {
                            return SearchListItems(
                                result: state.results[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
