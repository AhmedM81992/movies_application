import 'package:flutter/material.dart';
import 'package:movies_app/models/UpComingModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'fetch_api.dart';

class UpComingLocalDatabase {
  static late Database _database;
  static bool _isDatabaseInitialized = false;

  static Future<void> initDatabase() async {
    // Get the path where the database will be stored
    String path = join(await getDatabasesPath(), 'upcoming_api_data.db');

    // Open or create the database at the specified path
    _database = await openDatabase(
      path,
      version: 1, // Database version
      onCreate: (db, version) {
        // Callback function to create the database tables if they don't exist
        return db.execute(
          "CREATE TABLE upcoming_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    _isDatabaseInitialized = true;
  }

  static Future<Database> getDatabase() async {
    if (!_isDatabaseInitialized) {
      await initDatabase();
    }
    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await getDatabase();
    await db.insert(
      'upcoming_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future getData() async {
    final Database db = await getDatabase();

    List<Map<String, dynamic>> maps = await db.query('upcoming_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      // Calculate the time difference in milliseconds
      // ignore: unused_local_variable
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;
      // If the time difference is less than or equal to 24 hours, data is considered up to date
      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        debugPrint("Data is up to date for UpComingLocalDatabase");
        return latestData['data'];
      } else {
        // Data is expired, delete it from the database
        debugPrint("Deleting Data and replacing it");
        await deleteData();
        // Fetch new data from the API after deleting the old data
        var newData = await deleteAndFetchData();
        return newData; // Return the fetched data // Await the result of deleteAndFetchData
      }
    }
    debugPrint("Data Expired or Null for UpComingLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await getDatabase();
    await db.delete('upcoming_api_data');
  }

  static Future<UpcomingModel?> deleteAndFetchData() async {
    try {
      await deleteData();

      // Fetch new data from the API
      UpcomingModel? newData = await FetchAPI.getUpcoming();

      // Return the fetched data
      return newData;
    } catch (e) {
      debugPrint("Error while deleting and fetching data: $e");
      throw e; // Rethrow the error for handling elsewhere if needed
    }
  }
}
