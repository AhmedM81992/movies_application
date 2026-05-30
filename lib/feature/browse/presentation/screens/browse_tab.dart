import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/config/language/local_key.g.dart';
import 'package:movies_app/config/routes/route_arguments.dart';
import 'package:movies_app/config/theme/my_theme_data.dart';
import 'package:movies_app/core/shared_widgets/app_text.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/core/utils/size_config.dart';
import 'package:movies_app/feature/browse/presentation/business_logic/bloc/browse_bloc.dart';
import 'package:movies_app/feature/browse/presentation/business_logic/bloc/browse_state.dart';

import 'movies_for_one_category.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  void initState() {
    super.initState();
    context.read<BrowseBloc>().add(GetGenresEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeConfig.verticalSpace(16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: AppText(
              LocalKeys.categoryBrowse.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizeConfig.verticalSpace(8),
          Expanded(
            child: BlocBuilder<BrowseBloc, BrowseState>(
              builder: (context, state) {
                if (state.genresStatus == LoadStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyThemeData.selectedColor,
                    ),
                  );
                }
                if (state.genresStatus == LoadStatus.error) {
                  return const Center(child: Text("Something Went Wrong!"));
                }
                final categoryList = state.genres;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MoviesForOneCategory.routeName,
                            arguments: MoviesForOneCategoryArgs(
                              id: categoryList[index].id ?? 0,
                              name: categoryList[index].name ?? '',
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.sizeOf(context).height / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: const AssetImage(
                                "assets/images/browse/placeholder_image.png",
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                MyThemeData.blackColor.withOpacity(0.2),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                          child: Text(
                            categoryList[index].name ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
