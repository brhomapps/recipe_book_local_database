import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/ui/screens/search_recipe_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_provider.dart';
import '../widgets/recipe_widget.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Recipes'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Favorite Recipes:',
                  style: TextStyle(
                    fontSize: 16,
                    color: !myProvider.isDark
                        ? const Color.fromARGB(255, 244, 143, 177)
                        : null,
                  ),
                )
              ],
            ),
            actions: [
              InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchRecipeScreen(
                          recipes: myProvider.favoriteRecipes)))),
                  child: const Icon(Icons.search)),
              PopupMenuButton(
                color: !myProvider.isDark ? Colors.blue[200] : null,
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        onTap: (() => Scaffold.of(context).openDrawer()),
                        child: const Text('Open menu'),
                      ),
                      const PopupMenuItem(
                        child: Text('About'),
                      ),
                      PopupMenuItem(
                        onTap: (() => exit(0)),
                        child: Column(
                          children: [
                            const Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.exit_to_app_outlined,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Exit'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: !myProvider.isDark ? Colors.blue : null,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food_logo.png'),
                      radius: 50,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/main_recipe_screen');
                  },
                ),
                ListTile(
                  title: const Text('Favorite Recipes'),
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite_recipes_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  title: const Text('Shopping List'),
                  leading: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/shopping_list_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                Provider.of<RecipeClass>(context).isDark
                    ? ListTile(
                        title: const Text('Light Mode'),
                        leading: const Icon(
                          Icons.light_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        title: const Text('Dark Mode'),
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
          body: ListView.builder(
              itemCount: myProvider.favoriteRecipes.length,
              itemBuilder: (context, index) {
                return RecipeWidget(myProvider.favoriteRecipes[index]);
              }),
        );
      },
    );
  }
}
