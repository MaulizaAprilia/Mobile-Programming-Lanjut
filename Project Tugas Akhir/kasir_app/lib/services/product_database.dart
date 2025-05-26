// lib/services/product_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDatabase {
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
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price REAL NOT NULL,
          category TEXT
        )
      ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    final db = await getDatabase();
    return await db.query('products', where: 'category = ?', whereArgs: [category]);
  }

  static Future<int> insertProduct(String name, double price, String category) async {
    final db = await getDatabase();
    return await db.insert('products', {
      'name': name,
      'price': price,
      'category': category,
    });
  }
}
