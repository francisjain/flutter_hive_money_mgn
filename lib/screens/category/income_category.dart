import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/category/category_db.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().IncomeCategoryListNotifier,
        builder:
            (BuildContext ctx, List<CategoryModels> updatedList, Widget? _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final IncomeCategory = updatedList[index];
              return Card(
                child: ListTile(
                  title: Text(IncomeCategory.name),
                  trailing: IconButton(
                      onPressed: () {
                        CategoryDb().deleteCategory(IncomeCategory.id);
                      },
                      icon: Icon(Icons.delete)),
                ),
              );
            },
            separatorBuilder: (ctx, ind) => const SizedBox(
              height: 10,
            ),
            itemCount: CategoryDb().IncomeCategoryListNotifier.value.length,
          );
        });
  }
}
