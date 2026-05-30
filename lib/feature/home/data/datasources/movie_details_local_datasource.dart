import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MovieDetailsLocalDataSource {
  Future<String?> getCachedById(String id);
  Future<void> cacheById(String id, String jsonData);
  Future<void> clearById(String id);
  Future<String?> getCachedSimilar(String id);
  Future<void> cacheSimilar(String id, String jsonData);
}

class MovieDetailsLocalDataSourceImpl implements MovieDetailsLocalDataSource {
  Database? _database;
  final int _ttlMs = 24 * 60 * 60 * 1000;

  Future<Database> _getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path =
        join(await getDatabasesPath(), 'movie_details_cache.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE movie_details_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE similar_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE IF NOT EXISTS similar_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
          );
        }
      },
    );
  }

  @override
  Future<String?> getCachedById(String id) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'movie_details_cache',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final Map<String, dynamic> latestData = maps.first;
      final int timestamp = latestData['timestamp'] as int;
      final int timeDifference =
          DateTime.now().millisecondsSinceEpoch - timestamp;

      if (timeDifference <= _ttlMs) {
        debugPrint('Cache hit for movie_details_cache ID: $id');
        return latestData['data'] as String?;
      } else {
        debugPrint(
            'Cache expired for movie_details_cache ID: $id, deleting...');
        await db.delete(
          'movie_details_cache',
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }
    debugPrint('No valid cache found for movie_details_cache ID: $id');
    return null;
  }

  @override
  Future<void> cacheById(String id, String jsonData) async {
    final Database db = await _getDatabase();
    await db.insert(
      'movie_details_cache',
      {
        'id': id,
        'data': jsonData,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearById(String id) async {
    final Database db = await _getDatabase();
    await db.delete(
      'movie_details_cache',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<String?> getCachedSimilar(String id) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'similar_cache',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;

    final int age =
        DateTime.now().millisecondsSinceEpoch - (maps.first['timestamp'] as int);
    if (age > _ttlMs) {
      debugPrint('Cache expired for similar id=$id, deleting...');
      await db.delete('similar_cache', where: 'id = ?', whereArgs: [id]);
      return null;
    }
    debugPrint('Cache hit for similar id=$id');
    return maps.first['data'] as String;
  }

  @override
  Future<void> cacheSimilar(String id, String jsonData) async {
    final Database db = await _getDatabase();
    await db.insert(
      'similar_cache',
      {
        'id': id,
        'data': jsonData,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
