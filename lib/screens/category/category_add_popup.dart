import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/category/category_db.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

void ShowCategoryAddPopup(BuildContext context) {
  final _categoryTitleController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(title: Text('Add Category'), children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _categoryTitleController,
          decoration: InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRadioButton(title: 'Income', type: CategoryType.income),
            CustomRadioButton(title: 'Expense', type: CategoryType.expense),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              final _name = _categoryTitleController.text;
              if (_name.isEmpty) {
                return;
              }
              final _category = CategoryModels(
                  id: DateTime.now().toString(),
                  name: _name,
                  type: selectedCategoryNotifier.value);
              CategoryDb().insertCategory(_category);
              Navigator.pop(context);
              _categoryTitleController.clear();
              selectedCategoryNotifier.value = CategoryType.income;
              selectedCategoryNotifier.notifyListeners();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category Added')),
              );
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ))),
          ))
    ]),
  );
}

class CustomRadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const CustomRadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType updatedValue, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: updatedValue,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          }),
      Text(title),
    ]);
  }
}
