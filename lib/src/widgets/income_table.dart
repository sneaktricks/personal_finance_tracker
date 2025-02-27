import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';

/// Table that displays and ranks income by category.
/// Depends on data from [EntryController].
class IncomeTable extends StatelessWidget {
  IncomeTable({super.key});

  final entryController = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final incomeSum = entryController.incomeSum.toDouble();

    return DataTable(
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text(
              "#",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Sum",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "% of total",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: entryController
          .incomeByCategory()
          .entries
          .sortedBy((e) => -e.value)
          .mapIndexed((index, element) {
        return DataRow(cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text.rich(
            TextSpan(children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(categoryIdToIcon[element.key]),
              ),
              TextSpan(text: categoryIdToName[element.key] ?? "Unknown"),
            ]),
          )),
          DataCell(widthToView(width) < 1
              ? Text(
                  compactCurrencyFormat.format(element.value.toDouble() / 100))
              : Text(currencyFormat.format(element.value.toDouble() / 100))),
          DataCell(Text(
              percentageFormat.format(element.value.toDouble() / incomeSum))),
        ]);
      }).toList(),
    );
  }
}
