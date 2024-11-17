import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final entryController = Get.find<EntryController>();
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters["id"];
    final entry = entryController.findById(id!)!;

    final isIncome = entry is IncomeEntry;

    return Scaffold(
      body: ConstrainedView(
        maxWidth: 400,
        omitNavRail: true,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: const Text("ID"),
                    subtitle: Text(entry.id),
                  ),
                  ListTile(
                    title: const Text("Value"),
                    subtitle: Text(
                        currencyFormat.format(entry.value.toDouble() / 100)),
                  ),
                  ListTile(
                    title: Text(
                        "Proportion of Total ${isIncome ? 'Income' : 'Expenses'}"),
                    subtitle: Text(percentageFormat.format(
                        entry.value.toDouble() /
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
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () {
                if (isIncome) {
                  entryController.deleteIncome(entry);
                } else if (entry is ExpenseEntry) {
                  entryController.deleteExpense(entry);
                }
                navigationController.setTabIndexOff(2);
              },
              label: const Text("Delete"),
              icon: const Icon(Icons.delete_forever),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
            )
          ],
        ),
      ),
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
