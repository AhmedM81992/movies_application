import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeLocalDataSource {
  Future<String?> getCachedPopular();
  Future<void> cachePopular(String jsonData);
  Future<String?> getCachedTopRated();
  Future<void> cacheTopRated(String jsonData);
  Future<String?> getCachedUpcoming();
  Future<void> cacheUpcoming(String jsonData);
  Future<String?> getCachedDetails(String id);
  Future<void> cacheDetails(String id, String jsonData);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  Database? _database;
  final int _ttlMs = 24 * 60 * 60 * 1000;

  Future<Database> _getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'home_cache.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE popular_cache(id INTEGER PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE top_rated_cache(id INTEGER PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE upcoming_cache(id INTEGER PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE details_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE IF NOT EXISTS details_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
          );
        }
      },
    );
  }

  // --------------- Popular ---------------

  @override
  Future<String?> getCachedPopular() async {
    return _getCachedFromTable('popular_cache');
  }

  @override
  Future<void> cachePopular(String jsonData) async {
    await _cacheToTable('popular_cache', jsonData);
  }

  // --------------- TopRated ---------------

  @override
  Future<String?> getCachedTopRated() async {
    return _getCachedFromTable('top_rated_cache');
  }

  @override
  Future<void> cacheTopRated(String jsonData) async {
    await _cacheToTable('top_rated_cache', jsonData);
  }

  // --------------- Upcoming ---------------

  @override
  Future<String?> getCachedUpcoming() async {
    return _getCachedFromTable('upcoming_cache');
  }

  @override
  Future<void> cacheUpcoming(String jsonData) async {
    await _cacheToTable('upcoming_cache', jsonData);
  }

  // --------------- Details (keyed by movie ID) ---------------

  @override
  Future<String?> getCachedDetails(String id) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'details_cache',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;

    final int age =
        DateTime.now().millisecondsSinceEpoch - (maps.first['timestamp'] as int);
    if (age > _ttlMs) {
      debugPrint('Cache expired for details id=$id, deleting...');
      await db.delete('details_cache', where: 'id = ?', whereArgs: [id]);
      return null;
    }
    debugPrint('Cache hit for details id=$id');
    return maps.first['data'] as String;
  }

  @override
  Future<void> cacheDetails(String id, String jsonData) async {
    final Database db = await _getDatabase();
    await db.insert(
      'details_cache',
      {'id': id, 'data': jsonData, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --------------- Shared helpers ---------------

  Future<String?> _getCachedFromTable(String table) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(table, limit: 1);

    if (maps.isNotEmpty) {
      final int timestamp = maps.first['timestamp'] as int;
      final int age = DateTime.now().millisecondsSinceEpoch - timestamp;

      if (age <= _ttlMs) {
        debugPrint('Cache hit for $table');
        return maps.first['data'] as String;
      } else {
        debugPrint('Cache expired for $table, deleting...');
        await db.delete(table);
      }
    }
    debugPrint('No valid cache for $table');
    return null;
  }

  Future<void> _cacheToTable(String table, String jsonData) async {
    final Database db = await _getDatabase();
    await db.delete(table);
    await db.insert(
      table,
      {'data': jsonData, 'timestamp': DateTime.now().millisecondsSinceEpoch},
    );
  }
}
