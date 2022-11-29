// ignore_for_file: file_names
import 'dart:io';

import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionsColumn = 'instructions';
  final String preperationTimeColumn = 'preperationTime';
  final String imageColumn = 'image';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '$directory/recipes.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  insertNewRecipe(RecipeModel recipeModel) {
    database.insert(tableName, recipeModel.toMap());
  }

  deleteRecipe(RecipeModel recipeModel) {
    database
        .delete(tableName, where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }

  deleteRecipes() {
    database.delete(tableName);
  }

  updateRecipe(RecipeModel recipeModel) async {
    await database.update(
        tableName,
        {
          isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
          nameColumn: recipeModel.name,
          preperationTimeColumn: recipeModel.preperationTime,
          imageColumn: recipeModel.image!.path,
          ingredientsColumn: recipeModel.ingredients,
          instructionsColumn: recipeModel.instructions
        },
        where: '$idColumn=?',
        whereArgs: [recipeModel.id]);
  }

  updateIsFavorite(RecipeModel recipeModel) {
    database.update(
        tableName, {isFavoriteColumn: !recipeModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }
}
