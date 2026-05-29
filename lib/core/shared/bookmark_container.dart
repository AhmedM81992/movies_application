import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/feature/bookmarks/presentation/business_logic/cubit/bookmark_cubit.dart';
import 'package:movies_app/feature/home/data/models/results_model/results_model_response_model.dart';

class BookmarkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(
        size.width / 2, size.height * 0.7); // The "bookmark" indentation
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 1.25, 0, size.width - 10, 0);
    path.lineTo(10, 0); // Start of top left curve
    path.quadraticBezierTo(0, 0, 0, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ignore: must_be_immutable
class MyBookmarkWidget extends StatelessWidget {
  const MyBookmarkWidget({super.key, required this.moviesList});

  final Results moviesList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        final isClicked =
            context.read<BookmarkCubit>().isFavorite(moviesList.id ?? 0);

        return ClipPath(
          clipper: BookmarkClipper(),
          child: Container(
            color: isClicked
                ? const Color(0xFFF7B539).withValues(alpha: 0.8)
                : const Color(0xFF514F4F).withValues(alpha: 0.8),
            width: MediaQuery.sizeOf(context).width * 0.078,
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: Center(
              child: IconButton(
                icon: Icon(
                  isClicked ? Icons.check : Icons.add,
                  color: Colors.white,
                  size: 15,
                ),
                onPressed: () {
                  debugPrint(moviesList.title);
                  context.read<BookmarkCubit>().toggleFavorite(moviesList);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
