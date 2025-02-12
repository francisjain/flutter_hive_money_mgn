import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/category/category_db.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';
import 'package:hive_money_mgn/screens/category/category_add_popup.dart';
import 'package:hive_money_mgn/screens/transactions/add_transaction.dart';

import '../../widgets/bottom_navbar.dart';
import '../category/screen_category.dart';
import '../transactions/screen_transaction.dart';

class MyHomepage extends StatelessWidget {
  MyHomepage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [ScreenTransaction(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 245, 253),
      appBar: AppBar(
        title: Text(
          "Hive Money Manager",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updateIndex, _) {
                return _pages[updateIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print("Transaction");
            Navigator.of(context).pushNamed(AddTransaction.routeName);
          } else {
            print("Category");
            // final _sample = CategoryModels(
            //   id: DateTime.now().toString(),
            //   name: "Travel",
            //   type: CategoryType.expense,
            // );
            // CategoryDb().insertCategory(_sample);
            ShowCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
