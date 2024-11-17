import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';

/// Application-wide bottom navigation bar
class NavBar extends StatelessWidget {
  NavBar({super.key});

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      useLegacyColorScheme: false,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.attach_money), label: "Add Entry"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Transactions"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined), label: "Statistics"),
      ],
      currentIndex: navigationController.tabIndex.value,
      onTap: (i) => navigationController.setTabIndex(i),
    );
  }
}
