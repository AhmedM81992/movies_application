// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRatedModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'fetch_api.dart';

class TopRatedLocalDatabase {
  static Database? _database;

  static Future<Database> getDatabase() async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'top_rated_api_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE top_rated_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );
  }

  static Future<void> saveData(String data) async {
    final Database db = await getDatabase();
    await db.insert(
      'top_rated_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getData() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query('top_rated_api_data');

    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;

      if (timeDifference <= 24 * 60 * 60 * 1000) {
        debugPrint("Data is up to date for TopRatedLocalDatabase");
        return latestData['data'];
      } else {
        debugPrint("Deleting expired data and fetching new one...");
        await deleteData();
        return await deleteAndFetchData();
      }
    }
    debugPrint("No valid cache found for TopRatedLocalDatabase.");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await getDatabase();
    await db.delete('top_rated_api_data');
  }

  static Future<String?> deleteAndFetchData() async {
    await deleteData();

    TopRatedModel? newData = await FetchAPI.getToprated();

    if (newData != null) {
      String jsonData = jsonEncode(newData.toJson());
      await saveData(jsonData);
      return jsonData;
    }

    return null;
  }
}
