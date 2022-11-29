import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_provider.dart';
import '../widgets/recipe_widget.dart';

class AllRecipesScreen extends StatelessWidget {
  const AllRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, provider, Widget? child) {
        return ListView.builder(
            itemCount: provider.allRecipes.length,
            itemBuilder: (context, index) {
              return RecipeWidget(provider.allRecipes[index]);
            });
      },
    );
  }
}
