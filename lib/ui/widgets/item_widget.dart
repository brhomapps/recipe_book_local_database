import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item_model.dart';
import '../../providers/item_provider.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  const ItemWidget(this.itemModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: CheckboxListTile(
        value: itemModel.isComplete,
        onChanged: (bool? value) {
          Provider.of<ItemClass>(context, listen: false).updateItem(itemModel);
        },
        title: Text(itemModel.name),
        secondary: InkWell(
          child: const Icon(Icons.delete_outlined),
          onTap: () {
            Provider.of<ItemClass>(context, listen: false)
                .deleteItem(itemModel);
          },
        ),
      ),
    );
  }
}
