import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
import '../models/category.dart';

class DatabaseService {
  late Database db;

  // Inisialisasi database
  Future<void> initDB() async {
    db = await openDatabase(
      'kasir_app.db',
      version: 1,
      onCreate: (db, version) async {
        // Tabel produk
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            imageUrl TEXT
          )
        ''');

        // ✅ Tabel kategori
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT
          )
        ''');

        // Optional: Tambah data dummy kategori
        await db.insert('categories', {
          'name': 'Fruits',
          'description': 'Fresh fruits and produce'
        });

        await db.insert('categories', {
          'name': 'Beverages',
          'description': 'Drinks and refreshments'
        });
      },
    );
  }

  // ✅ Ambil semua produk
  Future<List<Product>> getAllProducts() async {
    final List<Map<String, dynamic>> maps = await db.query('products');
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  // ✅ Ambil semua kategori
  Future<List<Category>> getCategories() async {
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return maps.map((map) => Category.fromMap(map)).toList();
  }
}
