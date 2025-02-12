import 'package:flutter/material.dart';

import '../screens/home/screen_home.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyHomepage.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            onTap: (index) => {MyHomepage.selectedIndexNotifier.value = index},
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows), label: 'Transaction'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ],
          );
        });
  }
}
