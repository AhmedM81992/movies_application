import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase/firebase_functions.dart';
import 'package:movies_app/models/ResultsModel.dart';
import 'package:movies_app/screens/tabs/watch_list_sub_items/watch_list_items.dart';

class WatchListTab extends StatelessWidget {
  WatchListTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Watch List',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set title text color
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Results>>(
              stream: FireBaseFunctions.getFavorites(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator());
                }
                var favorites = snapshot.data!.docs
                    .map((e) => e.data())
                    .toList();
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return WatchListItems(
                        result: favorites[index]);
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
