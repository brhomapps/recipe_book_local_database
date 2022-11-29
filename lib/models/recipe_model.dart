import 'dart:io';

class RecipeModel {
  int? id;
  late String name;
  late bool isFavorite;
  File? image;
  late int preperationTime;
  late String ingredients;
  late String instructions;

  RecipeModel({
    this.id,
    required this.name,
    required this.isFavorite,
    this.image,
    required this.preperationTime,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite ? 1 : 0,
      'preperationTime': preperationTime,
      'ingredients': ingredients,
      'instructions': instructions,
      'image': image == null ? '' : image!.path
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
        id: map['id'],
        name: map['name'],
        isFavorite: map['isFavorite'] == 1 ? true : false,
        preperationTime: map['preperationTime'],
        ingredients: map['ingredients'],
        instructions: map['instructions'],
        image: map['image'] != null ? File(map['image']) : null);
  }
}
