import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class PageBase extends StatelessWidget {
  PageBase({super.key, required this.child});

  final navigationController = Get.find<NavigationController>();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ConstrainedView(child: child),
      bottomNavigationBar: widthToView(width) < 1 ? NavBar() : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationController.setTabIndex(1);
        },
        tooltip: "Add income or expense",
        child: const Icon(Icons.add),
      ),
    );
  }
}
