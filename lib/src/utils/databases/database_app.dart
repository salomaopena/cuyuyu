import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/models/wish_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  /// Local database SQLite
  static final _databaseName = "cuyuyu.db";
  static final _databaseVersion = 1;

  //Cart table
  static final table = "cart";
  //Fields Names
  static final id = "id";
  static final prodId = "product_id";
  static final name = "product";
  static final image = "image";
  static final description = "description";
  static final variation = "variation";
  static final unity = "unity";
  static final price = "price";
  static final discount = "discount";
  static final iva = "iva";
  static final quantity = "quantity";
  static final shop = "shop";
  static final nameShopping = "name_shopping";
  static final frete = "frete";

/**
   * Finish cart table
   * **/


  /// create table Wishlist

  static final wishListTable = "wishlist";
  //Fields table
  static final wishId = "wish_id";
  static final productId = "product_id";
  static final productName = "name_product";
  static final imageUrl = "image_url_product";
  static final productDescr = "description_product";
  static final productVaria = "variation_id";
  static const category = "product_category_id";
  static final productUnit = "unity_id";
  static final productOldPrice = "old_price_product";
  static final productPrice = "price_product";
  static final productDiscount = "discount_product";
  static final productIva = "iva_product";
  static final disponibility = "is_disponible";
  static final prductFeatured = "featured_product";
  static final productMinimum = "minimum_number_product";
  static final productShop = "id_shop";
  static final productStarCount = "start_count_product";
  static final productFrete = "product_frete";

  DatabaseApp._privateConstrutor();

  static final DatabaseApp instance = DatabaseApp._privateConstrutor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    List<String> queryes = [
      "CREATE TABLE $table ($id INTEGER PRIMARY KEY AUTOINCREMENT, $prodId TEXT NOT NULL, $name TEXT NOT NULL,$image TEXT NULL, $description TEXT NULL,$variation TEXT NUll,$unity TEXT NULL,$price TEXT NULL,$discount TEXT NULL,$iva TEXT NULL, $quantity TEXT NULL, $shop TEXT NULL, $nameShopping TEXT NULL, $frete TEXT NULL);",
      "CREATE TABLE $wishListTable ($wishId INTEGER PRIMARY KEY AUTOINCREMENT, $productId TEXT NOT NULL, $productName TEXT NOT NULL, $imageUrl TEXT NULL, $productDescr TEXT NULL,$productVaria TEXT NULL,$category TEXT NULL,$productUnit TEXT NULL,$productOldPrice TEXT NULL,$productPrice TEXT NULL,$productDiscount TEXT NULL, $productIva TEXT NULL, $disponibility TEXT NULL, $prductFeatured TEXT NULL,$productMinimum TEXT NULL, $productShop TEXT NULL, $productStarCount TEXT NULL, $productFrete TEXT NULL);",
    ];

    for (String query in queryes) {
      await db.execute(query);
    }
  }


/*
 * ---------------------------------CRUD Cart Area--------------------------------------
 * Bellow is de cart area code
 * */


  Future<int> addToCart(CartModel model) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getCarts() async {
    Database db = await instance.database;
    return await db.query(table);
  }


/*Future<List<Map<String, dynamic>>> getCarts() async {
    Database db = await instance.database;
    var query = "SELECT * FROM cart";
    return await db.rawQuery(query);
  }*/


  Future<int> removeFromCart(CartModel model) async {
    Database db = await instance.database;
    return await db
        .rawDelete('DELETE FROM $table WHERE $id = ${model.cartId} ');
  }

  Future<int> getCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> deleteCart() async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<int> updateCart(CartModel model) async {
    Database db = await instance.database;
    var sql =
        "UPDATE cart SET quantity = ${model.cartQuantity} WHERE product_id = ${model.cartProdId}";
    return await db.rawUpdate(sql);
  }

  Future<int> inecreaseCart(CartModel model) async {
    Database db = await instance.database;
    var sql =
        "UPDATE cart SET quantity = quantity + 1 WHERE $id = ${model.cartId}";
    return await db.rawUpdate(sql);
  }

  Future<int> singleUpdate(CartModel model) async {
    Database db = await instance.database;
    var sql =
        "UPDATE cart SET $quantity = $quantity + 1 WHERE $prodId = ${model.cartProdId}";
    return await db.rawUpdate(sql);
  }

  Future<int> decreaseCart(CartModel model) async {
    Database db = await instance.database;
    var sql =
        "UPDATE cart SET quantity = quantity - 1 WHERE $id = ${model.cartId}";
    return await db.rawUpdate(sql);
  }

  Future<List<Map<String, dynamic>>> isInCart(CartModel model) async {
    Database db = await instance.database;
    return await db
        .query(table, where: '$prodId = ?', whereArgs: [model.cartProdId]);
  }

  Future<double> getTotalPrice() async {
    final db = await database;
    List<Map> list = await db.rawQuery("SELECT SUM($price)  FROM cart");
    return list.isNotEmpty ? list[0]['$price'] : Null;
  }


/*
   * Create Favorite functions or method
   * */


  Future<int> addToFavorite(WishListModel model) async {
    Database db = await instance.database;
    return await db.insert(
      wishListTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    Database db = await instance.database;
    return await db.query(wishListTable);
  }

  Future<int> removeFromFavorite(WishListModel model) async {
    Database db = await instance.database;
    return await db
        .delete(wishListTable, where: '$productId = ? ', whereArgs: [model.id]);
  }

  Future<List<Map<String, dynamic>>> isFavorite(WishListModel model) async {
    Database db = await instance.database;
    return await db
        .query(wishListTable, where: '$productId = ?', whereArgs: [model.id]);
  }
}

