import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'db_product.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(path, onCreate: _onCreate, version: 2
        // ,
        // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
        );
  }

  Future<void> _onCreate(Database db, int version) async {
    // await db.execute(
    //     'CREATE TABLE product_favorite(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,price INTEGER,img TEXT, des TEXT, catid INTEGER);');

    await db.execute(
        'CREATE TABLE product (id INTEGER PRIMARY KEY AUTOINCREMENT,  name TEXT,  description TEXT,  imageURL TEXT,  price INTEGER,  categoryID INTEGER,  categoryName TEXT,  isFavorite BOOLEAN);');
  }

  Future<void> insertProduct(Product productModel) async {
    final db = await _databaseService.database;

    await db.insert(
      'product',
      productModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> productsFavorite() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('product');
    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }
}
