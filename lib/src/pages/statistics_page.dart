import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/expense_table.dart';
import 'package:personal_finance_tracker/src/widgets/income_table.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  final navigationController = Get.find<NavigationController>();
  final RxList<bool> selectedTab = [true, false].obs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ConstrainedView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => Center(
                child: ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: const BoxConstraints(
                    minWidth: 80.0,
                    minHeight: 40.0,
                  ),
                  onPressed: (i) => selectedTab.value = [i == 0, i != 0],
                  isSelected: selectedTab,
                  children: const [
                    Text("Income"),
                    Text("Expenses"),
                  ],
                ),
              ),
            ),
            Obx(() => selectedTab.first ? IncomeTable() : ExpenseTable()),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("All-Time Statistics"),
      ),
      bottomNavigationBar: widthToView(width) < 1 ? NavBar() : null,
    );
  }
}
