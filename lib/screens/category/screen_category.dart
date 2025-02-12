import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/category/category_db.dart';

import 'expence_category.dart';
import 'income_category.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreashUI();
    CategoryDb().getCategories().then((onValue)=>{print(onValue.toString())});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            IncomeCategory(),
            ExpanceCategory(),
          ]),
        )
      ],
    );
  }
}
