import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DetailsLocalDatabase {
  static Database? _database;
  static final StreamController<String?> _dataStreamController =
      StreamController.broadcast();
  static Stream<String?> get dataStream => _dataStreamController.stream;

  static Future<Database> getDatabase() async {
    _database ??= await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'details_api_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE details_api_data(id TEXT PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );
  }

  static Future<void> saveData(String id, String data) async {
    final Database db = await getDatabase();
    await db.insert(
      'details_api_data',
      {
        'id': id,
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("✅ Data saved for DetailsLocalDatabase (ID: $id)");
    _dataStreamController.add(data);
  }

  static Future<String?> getData(String id) async {
    final Database db = await getDatabase();

    List<Map<String, dynamic>> maps = await db.query(
      'details_api_data',
      where: 'id = ?',
      whereArgs: [id],
    );

    debugPrint("🔍 Query result for ID $id"); // Print query result
    maps.toString()
        .split(",")
        // ignore: prefer_interpolation_to_compose_strings
        .forEach((line) => debugPrint(
            "Data Stored::>> ${line.replaceFirst(":", '":').replaceFirst("{", "").replaceFirst("}", "").replaceFirst("[", "").replaceFirst("]", "")},"
                .replaceFirst('" ', '"')));

    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];

      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        debugPrint("✅ Data is up to date for DetailsLocalDatabase (ID: $id)");
        return latestData['data'];
      } else {
        debugPrint("⏳ Data expired for ID: $id. Deleting...");
        await deleteData(id);
      }
    }

    debugPrint("❌ No valid cached data found for ID: $id.");
    return null;
  }

  static Future<void> deleteData(String id) async {
    final Database db = await getDatabase();
    await db.delete('details_api_data', where: 'id = ?', whereArgs: [id]);
    _dataStreamController.add(null);
  }
}
