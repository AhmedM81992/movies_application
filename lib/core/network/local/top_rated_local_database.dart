// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:movies_app/models/TopRatedModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'fetch_api.dart';

class TopRatedLocalDatabase {
  static late Database _database;
  // ignore: unused_field
  static bool _isDatabaseInitialized = false;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'top_rated_api_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE top_rated_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    _isDatabaseInitialized = true;
    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await database;
    await db.insert(
      'top_rated_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future getData() async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.query('top_rated_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      // Calculate the time difference in milliseconds
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;
      // If the time difference is less than or equal to 24 hours, data is considered up to date
      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        print("Data is up to date for UpComingLocalDatabase");
        return latestData['data'];
      } else {
        // Data is expired, delete it from the database
        print("Deleting Data and replacing it");
        await deleteData();
        // Fetch new data from the API after deleting the old data
        var newData = await deleteAndFetchData();
        return newData; // Return the fetched data
      }
    }
    print("Data Expired or Null for UpComingLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('top_rated_api_data');
  }

  static Future<TopRatedModel?> deleteAndFetchData() async {
    try {
      await deleteData();

      // Fetch new data from the API
      TopRatedModel? newData = await FetchAPI.getToprated();

      // Return the fetched data
      return newData;
    } catch (e) {
      print("Error while deleting and fetching data: $e");
      throw e; // Rethrow the error for handling elsewhere if needed
    }
  }
}
