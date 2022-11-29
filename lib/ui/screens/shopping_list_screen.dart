import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item_provider.dart';
import '../../providers/recipe_provider.dart';
import '../widgets/item_widget.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeClass, ItemClass>(
        builder: ((context, provider, provider2, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Shopping List'),
              actions: [
                InkWell(
                    onTap: () => provider2.deleteItems(),
                    child: const Icon(Icons.delete))
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.blue[200],
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.blue,
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
                  provider.isDark
                      ? ListTile(
                          title: const Text('Light Mode'),
                          leading: const Icon(
                            Icons.light_mode_outlined,
                            color: Colors.black,
                          ),
                          onTap: () {
                            provider.changeIsDark();
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
                            provider.changeIsDark();
                            Navigator.pop(context);
                          },
                        ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: provider2.allItems.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(provider2.allItems[index]);
                      }),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: provider2.textEditingController,
                        decoration: InputDecoration(
                            label: const Text('Item Name'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider2.insertNewItem();
                        provider2.textEditingController.clear();
                      },
                      child: const Text('Add Item'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ))));
  }
}
