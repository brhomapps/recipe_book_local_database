import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

import 'edit_recipe_screen.dart';

class ShowRecipeScreen extends StatelessWidget {
  final RecipeModel recipeModel;

  const ShowRecipeScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: ((context, provider, child) => Scaffold(
              appBar: AppBar(
                actions: [
                  InkWell(
                      onTap: () {
                        provider.nameController.text = recipeModel.name;
                        provider.preperationTimeController.text =
                            recipeModel.preperationTime.toString();
                        provider.ingredientsController.text =
                            recipeModel.ingredients;
                        provider.instructionsController.text =
                            recipeModel.instructions;
                        provider.image = recipeModel.image;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditRecipeScreen(
                                    recipeModel: recipeModel))));
                      },
                      child: const Icon(Icons.edit)),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        provider.deleteRecipe(recipeModel);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.delete)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.blue
                            : null,
                        borderRadius: BorderRadius.circular(5)),
                    height: 170,
                    //width: double.infinity,
                    child: recipeModel.image == null
                        ? const Center(
                            child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/food_logo.png'),
                          ))
                        : Image.file(
                            recipeModel.image!,
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      recipeModel.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.blue[100]
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Text(
                          'Preperation time :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${recipeModel.preperationTime} mins',
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.blue[100]
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          recipeModel.ingredients,
                          style: const TextStyle(fontSize: 26),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.blue[100]
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Instructions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          recipeModel.instructions,
                          style: const TextStyle(fontSize: 26),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            )));
  }
}
