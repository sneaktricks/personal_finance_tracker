import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/widgets/expense_table.dart';

/// Conditionally displays an [ExpenseTable], or a special view
/// if the table is empty.
/// Depends on data from [EntryController].
class OptionalExpenseTable extends StatelessWidget {
  final entryController = Get.find<EntryController>();

  OptionalExpenseTable({super.key});

  @override
  Widget build(BuildContext context) {
    if (entryController.expenseEntries.isEmpty) {
      return const Column(
        children: [
          SizedBox(height: 40),
          Icon(
            Icons.credit_card,
            size: 70,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            "No expense entries",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 10),
          Text(
            "Navigate to Add Entry to create one!",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      );
    }
    return ExpenseTable();
  }
}
