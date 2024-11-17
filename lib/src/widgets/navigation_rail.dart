import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';

/// Application-wide navigation rail
class NavRail extends StatelessWidget {
  NavRail({super.key});

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return NavigationRail(
      labelType: widthToView(width) < 2
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text("Home")),
        NavigationRailDestination(
            icon: Icon(Icons.attach_money), label: Text("Add Entry")),
        NavigationRailDestination(
            icon: Icon(Icons.list), label: Text("Transactions")),
        NavigationRailDestination(
            icon: Icon(Icons.bar_chart_outlined), label: Text("Statistics")),
      ],
      selectedIndex: navigationController.tabIndex.value,
      onDestinationSelected: (i) => navigationController.setTabIndex(i),
    );
  }
}
