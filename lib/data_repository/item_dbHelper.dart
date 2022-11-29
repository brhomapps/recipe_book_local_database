import 'dart:io';

import 'package:recipe_book_local_database/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ItemDbHelper {
  late Database database;
  static ItemDbHelper dbHelper = ItemDbHelper();
  final String tableName = 'items';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isCompleteColumn = 'isComplete';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '$directory/items.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $isCompleteColumn INTEGER)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $isCompleteColumn INTEGER)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  Future<List<ItemModel>> getAllItems() async {
    List<Map<String, dynamic>> items = await database.query(tableName);
    return items.map((e) => ItemModel.fromMap(e)).toList();
  }

  insertNewItem(ItemModel itemModel) {
    database.insert(tableName, itemModel.toMap());
  }

  deleteItem(ItemModel itemModel) {
    database.delete(tableName, where: '$idColumn=?', whereArgs: [itemModel.id]);
  }

  deleteItems() {
    database.delete(tableName);
  }

  updateItem(ItemModel itemModel) {
    database.update(
        tableName, {isCompleteColumn: !itemModel.isComplete ? 1 : 0},
        where: '$idColumn=?', whereArgs: [itemModel.id]);
  }
}
