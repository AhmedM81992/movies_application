import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase/firebase_functions.dart';

import '../../models/ResultsModel.dart';

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

class MyBookmarkWidget extends StatefulWidget {
  MyBookmarkWidget({required this.moviesList});

  Results moviesList;

  @override
  State<MyBookmarkWidget> createState() => _MyBookmarkWidgetState();
}

class _MyBookmarkWidgetState extends State<MyBookmarkWidget> {
  bool isClicked = false;

  List<Results> favList = [];

  isFavorite() {
    favList.forEach((element) {
      if (element.id == widget.moviesList.id) {
        isClicked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Results>>(
      stream: FireBaseFunctions.getFavorites(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Results>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return bookMark();
        }
        favList = snapshot.data!.docs.map((e) => e.data()).toList();
        isFavorite();

        return bookMark();
      },
    );
  }

  void updateFav() {
    if (favList.isEmpty || !isClicked) {
      add();
    } else {
      favList.forEach((element) {
        if (element.id == widget.moviesList.id) {
          delete(element.fireBaseId ?? '');
        }
      });
    }
    setState(() {});
  }

  add() {
    FireBaseFunctions.addMovie(widget.moviesList);
    isClicked = true;
  }

  delete(String fireBaseId) {
    FireBaseFunctions.deleteFavorites(fireBaseId);
    isClicked = false;
  }

  Widget bookMark() {
    return ClipPath(
      clipper: BookmarkClipper(),
      child: Container(
        color: isClicked
            ? Color(0xFFF7B539).withOpacity(0.8)
            : Color(0xFF514F4F).withOpacity(0.8),
        width:
            MediaQuery.sizeOf(context).width * 0.078, // Sets width for bookmark
        height: MediaQuery.sizeOf(context).height *
            0.05, // Sets height for bookmark
        child: Center(
          child: IconButton(
            icon: Icon(
              isClicked ? Icons.check : Icons.add,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () {
              print(widget.moviesList.title);
              updateFav();
            },
          ),
        ),
      ),
    );
  }
}
