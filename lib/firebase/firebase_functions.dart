import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/ResultsModel.dart';

class FireBaseFunctions {
  static CollectionReference<Results>
      getFavoritesCollection() {
    return FirebaseFirestore.instance
        .collection('Fav')
        .withConverter<Results>(
            fromFirestore: (snapshot, _) {
      return Results.fromJson(snapshot.data() ?? {});
    }, toFirestore: (result, _) {
      return result.toJson();
    });
  }

  static void addMovie(Results results) {
    var collection = getFavoritesCollection();
    //to generate auto id
    var doc = collection.doc();
    results.fireBaseId = doc.id;
    doc.set(results);
  }

  static Stream<QuerySnapshot<Results>> getFavorites() {
    return getFavoritesCollection().snapshots();
  }

  static void deleteFavorites(String id) {
    getFavoritesCollection().doc(id).delete();
  }
}
