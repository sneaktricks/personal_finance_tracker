import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/widgets/income_table.dart';

/// Conditionally displays an [IncomeTable], or a special view
/// if the table is empty.
/// Depends on data from [EntryController].
class OptionalIncomeTable extends StatelessWidget {
  final entryController = Get.find<EntryController>();

  OptionalIncomeTable({super.key});

  @override
  Widget build(BuildContext context) {
    if (entryController.incomeEntries.isEmpty) {
      return const Column(
        children: [
          SizedBox(height: 40),
          Icon(
            Icons.monetization_on,
            size: 70,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            "No income entries",
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
    return IncomeTable();
  }
}
