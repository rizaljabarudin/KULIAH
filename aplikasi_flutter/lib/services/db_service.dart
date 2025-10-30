import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../models/product.dart';

class DBService extends ChangeNotifier {
  static final DBService instance = DBService._init();
  static Database? _db;

  DBService._init();

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'aplikasi_flutter.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT NOT NULL,
        name TEXT,
        description TEXT,
        price REAL,
        stock INTEGER,
        imagePath TEXT
      )
    ''');
  }

  Future<List<Product>> getProducts() async {
    final db = _db!;
    final res = await db.query('products', orderBy: 'id DESC');
    return res.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> addProduct(Product p) async {
    final db = _db!;
    final id = await db.insert('products', p.toMap());
    notifyListeners();
    return id;
  }

  Future<int> updateProduct(Product p) async {
    final db = _db!;
    final res = await db.update(
      'products',
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
    notifyListeners();
    return res;
  }

  Future<int> deleteProduct(int id) async {
    final db = _db!;
    final res = await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
    return res;
  }
}
