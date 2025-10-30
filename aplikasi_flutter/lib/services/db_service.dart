import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class DBService extends ChangeNotifier {
  // ✅ Singleton instance
  static final DBService instance = DBService._init();
  static Database? _db;

  DBService._init();

  // ✅ Inisialisasi database
  Future<void> init() async {
    if (_db != null) return; // Mencegah inisialisasi ganda

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'aplikasi_flutter.db');

    _db = await openDatabase(path, version: 1, onCreate: _onCreate);

    if (kDebugMode) {
      print('✅ Database initialized at: $path');
    }
  }

  // ✅ Membuat tabel produk
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT NOT NULL,
        name TEXT,
        description TEXT,
        price REAL,
        stock INTEGER,
        imagePath TEXT
      )
    ''');
    if (kDebugMode) {
      print('✅ Table "products" created successfully');
    }
  }

  // ✅ Ambil semua produk
  Future<List<Product>> getProducts() async {
    final db = _db;
    if (db == null) throw Exception("Database belum diinisialisasi.");

    final res = await db.query('products', orderBy: 'id DESC');
    return res.map((e) => Product.fromMap(e)).toList();
  }

  // ✅ Tambah produk baru
  Future<int> addProduct(Product p) async {
    final db = _db;
    if (db == null) throw Exception("Database belum diinisialisasi.");

    final id = await db.insert('products', p.toMap());
    notifyListeners();
    if (kDebugMode) print('🟢 Produk ditambahkan: ${p.name}');
    return id;
  }

  // ✅ Update data produk
  Future<int> updateProduct(Product p) async {
    final db = _db;
    if (db == null) throw Exception("Database belum diinisialisasi.");

    final res = await db.update(
      'products',
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
    notifyListeners();
    if (kDebugMode) print('🟡 Produk diperbarui: ${p.name}');
    return res;
  }

  // ✅ Hapus produk
  Future<int> deleteProduct(int id) async {
    final db = _db;
    if (db == null) throw Exception("Database belum diinisialisasi.");

    final res = await db.delete('products', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
    if (kDebugMode) print('🔴 Produk dihapus (id: $id)');
    return res;
  }
}
