// ignore_for_file: unnecessary_null_comparison

import 'package:movies_app/core/network/local/fetch_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/PopularModel.dart';

class PopularLocalDatabase {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'popular_api_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE popular_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await database;
    await db.insert(
      'popular_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future getData() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('popular_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      // Calculate the time difference in milliseconds
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;
      // If the time difference is less than or equal to 24 hours, data is considered up to date
      if (timeDifference <= 24 * 60 * 60 * 1000) {
        print("Data is up to date for PopularLocalDatabase");
        return latestData['data'];
      } else {
        // Data is expired, delete it from the database
        await deleteData();
        // Fetch new data from the API after deleting the old data
        var newData = await deleteAndFetchData();
        return newData; // Return the fetched data // Await the result of deleteAndFetchData
      }
    }
    print("Data Expired or Null for PopularLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('popular_api_data');
  }

  static Future<PopularModel?> deleteAndFetchData() async {
    try {
      // Delete the old data from the database
      await deleteData();

      // Fetch new data from the API
      PopularModel? newData = await FetchAPI.getPopular();

      // Return the fetched data
      return newData;
    } catch (e) {
      print("Error while deleting and fetching data: $e");
      throw e; // Rethrow the error for handling elsewhere if needed
    }
  }
}
