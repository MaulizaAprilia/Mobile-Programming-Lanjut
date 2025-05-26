// lib/services/category_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CategoryDatabase {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kasir_app.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await getDatabase();
    return await db.query('categories');
  }

  static Future<int> insertCategory(String name) async {
    final db = await getDatabase();
    return await db.insert('categories', {'name': name});
  }
}
