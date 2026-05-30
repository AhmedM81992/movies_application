import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseHelper {
  Database? _database;

  Future<Database> getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
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
            'CREATE TABLE IF NOT EXISTS details_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
          );
          await db.execute(
            'CREATE TABLE IF NOT EXISTS similar_cache(id TEXT PRIMARY KEY, data TEXT NOT NULL, timestamp INTEGER NOT NULL)',
          );
        }
      },
    );
  }
}
