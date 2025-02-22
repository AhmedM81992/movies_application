import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DetailsLocalDatabase {
  static late Database _database;
  static bool _isDatabaseInitialized = false;

  static late StreamController<String?> _dataStreamController;
  static Stream<String?> get dataStream => _dataStreamController.stream;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'details_api_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE details_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    _isDatabaseInitialized = true;
    _dataStreamController = StreamController.broadcast();
    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await database;
    await db.insert(
      'details_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _dataStreamController.add(data); // Notify listeners about new data
  }

  static Future<String?> getData() async {
    if (!_isDatabaseInitialized) {
      print("Database is not initialized DetailsLocalDatabase.");
      await initDatabase();
    }

    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('details_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        print("Data is up to date for DetailsLocalDatabase");
        return latestData['data'];
      }
    }
    print("Data Expired or Null for TopRatedLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('details_api_data');
    _dataStreamController.add(null); // Notify listeners about data deletion
  }
}
