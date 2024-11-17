import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final entryController = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // The code below calculates the current month balance,
    // ranging from the first day of the current month to the
    // first day of the following month.
    var now = DateTime.now();
    var monthStart = DateTime(now.year, now.month);
    var monthEnd =
        DateTime(now.year + (now.month == 12 ? 1 : 0), (now.month % 12 + 1));
    var incomeThisMonth = entryController
        .findByCriteria<IncomeEntry>(monthStart, monthEnd, null)
        .map((e) => e.value)
        .fold(BigInt.zero, (a, b) => a + b)
        .obs;
    var expensesThisMonth = entryController
        .findByCriteria<ExpenseEntry>(monthStart, monthEnd, null)
        .map((e) => e.value)
        .fold(BigInt.zero, (a, b) => a + b)
        .obs;
    var balanceThisMonth =
        (incomeThisMonth.value - expensesThisMonth.value).obs;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your balance this month",
            style: TextStyle(fontSize: 20),
          ),
          Obx(
            () => Text(
              widthToView(width) < 1
                  ? formatCompactCurrency(balanceThisMonth.value.toDouble())
                  : currencyFormat
                      .format(balanceThisMonth.value.toDouble() / 100),
              style: TextStyle(
                  fontSize: 50,
                  color: switch (balanceThisMonth.value.toDouble()) {
                    < 0 => Colors.red,
                    > 0 => Colors.green,
                    _ => Colors.black,
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
