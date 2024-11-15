import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final entryController = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final id = Get.parameters["id"];
    final entry = entryController.findById(id!)!;

    final isIncome = entry is IncomeEntry;

    return Scaffold(
      body: ConstrainedView(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Value"),
              subtitle:
                  Text(currencyFormat.format(entry.value.toDouble() / 100)),
            ),
            ListTile(
              title: Text("% of Total ${isIncome ? 'Income' : 'Expenses'}"),
              subtitle: Text(percentageFormat.format(entry.value.toDouble() /
                  (isIncome
                      ? entryController.incomeSum.toDouble()
                      : entryController.expenseSum.toDouble()))),
            ),
            ListTile(
              title: const Text("Date"),
              subtitle: Text(dateFormat.format(entry.timestamp)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widthToView(width) < 1 ? NavBar() : null,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          tooltip: "Back",
        ),
        title: Text(categoryIdToName[entry.category] ?? "Other"),
      ),
    );
  }
}
