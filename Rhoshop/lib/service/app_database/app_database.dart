export 'cart_item.dart';

import 'package:path/path.dart';
import 'package:rhoshop/service/app_database/cart_item.dart';
import 'package:sqflite/sqflite.dart';

/// Represents application local database.
class AppDatabase {
  AppDatabase._();

  /// Singleton instance.
  static final AppDatabase instance = AppDatabase._();

  final _databaseName = 'rhoshop.db';
  final _cartItemsTableName = 'cart_items';
  Database _database;

  /// Gets SQLite database.
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  /// Initializes database.
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), _databaseName),
        version: 1,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $_cartItemsTableName ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "product TEXT NOT NULL,"
          "product_color TEXT NOT NULL,"
          "product_size TEXT NOT NULL,"
          "product_count INTEGER NOT NULL"
          ")");
    });
  }

  Future<CartItem> addCartItem(CartItem cartItem) async {
    final db = await database;
    cartItem.id = await db.insert(
      _cartItemsTableName,
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return cartItem;
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> cartItems = await db.query(
      _cartItemsTableName,
      orderBy: "id DESC",
    );

    return cartItems.map<CartItem>((o) => CartItem.fromMap(o)).toList();
  }

  Future updateCartItemCount(CartItem cartItem) async {
    final db = await database;
    await db.update(
      _cartItemsTableName,
      cartItem.toMap(),
      where: "id = ?",
      whereArgs: [cartItem.id],
    );
  }

  Future removeCartItem(CartItem cartItem) async {
    final db = await database;
    await db.delete(
      _cartItemsTableName,
      where: "id = ?",
      whereArgs: [cartItem.id],
    );
  }

  Future removeAllCartItems() async {
    final db = await database;
    await db.delete(_cartItemsTableName);
  }
}
