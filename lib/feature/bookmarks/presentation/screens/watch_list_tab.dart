import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/shared_widgets/app_text.dart';
import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/bookmarks/presentation/business_logic/bloc/bookmark_bloc.dart';
import 'package:movies_app/feature/bookmarks/presentation/business_logic/bloc/bookmark_state.dart';
import 'package:movies_app/feature/bookmarks/presentation/widgets/watch_list_items.dart';

class WatchListTab extends StatefulWidget {
  const WatchListTab({super.key});

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkBloc>().add(ListenFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppText(
              'Watch List',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BookmarkBloc, BookmarkState>(
              builder: (BuildContext context, state) {
                if (state.status == LoadStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == LoadStatus.error) {
                  return Center(
                    child: AppText(
                      state.error ?? 'An error occurred',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                final favorites = state.favorites;
                if (favorites.isEmpty) {
                  return const Center(
                    child: AppText(
                      'No favorites yet',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return WatchListItems(entity: favorites[index]);
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
