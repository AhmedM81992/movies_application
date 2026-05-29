import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/core/local_cache/fetch_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:movies_app/feature/home/data/models/upcoming_model/upcoming_model_response_model.dart';

class UpComingLocalDatabase {
  static Database? _database;

  static Future<Database> getDatabase() async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'upcoming_api_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE upcoming_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );
  }

  static Future<void> saveData(String data) async {
    final Database db = await getDatabase();
    await db.insert(
      'upcoming_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getData() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query('upcoming_api_data');

    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;

      if (timeDifference <= 24 * 60 * 60 * 1000) {
        debugPrint("Data is up to date for UpComingLocalDatabase");
        return latestData['data'];
      } else {
        debugPrint("Deleting Data and replacing it");
        await deleteData();
        return await deleteAndFetchData();
      }
    }
    debugPrint("Data Expired or Null for UpComingLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await getDatabase();
    await db.delete('upcoming_api_data');
  }

  static Future<String?> deleteAndFetchData() async {
    await deleteData();

    UpcomingModel? newData = await FetchAPI.getUpcoming();

    if (newData != null) {
      String jsonData = jsonEncode(newData.toJson());
      await saveData(jsonData);
      return jsonData;
    }

    return null;
  }
}
