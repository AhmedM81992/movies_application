// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/core/network/local/fetch_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:movies_app/feature/home/data/models/popular_model/popular_model_response_model.dart';

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
      int timeDifference = DateTime.now().millisecondsSinceEpoch - timestamp;

      if (timeDifference <= 24 * 60 * 60 * 1000) {
        debugPrint("Data is up to date for PopularLocalDatabase");
        return latestData['data'];
      } else {
        await deleteData();
        return await deleteAndFetchData(); // Ensure no infinite loop
      }
    }
    return null;
  }

  static Future<PopularModel?> deleteAndFetchData() async {
    await deleteData();
    PopularModel? newData = await FetchAPI.getPopular();

    if (newData != null) {
      await saveData(jsonEncode(newData.toJson())); // Cache the new data
    }

    return newData;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('popular_api_data');
  }
}
