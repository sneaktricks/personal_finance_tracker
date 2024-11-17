import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/entry_filter_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/date_range_filter_slider.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';
import 'package:personal_finance_tracker/src/widgets/optional_transactions_list.dart';

class TransactionsPage extends StatelessWidget {
  TransactionsPage({super.key});

  final entryController = Get.find<EntryController>();
  final navigationController = Get.find<NavigationController>();
  final entryFilterController = Get.find<EntryFilterController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var entries = entryController.entries.obs;
    entries.value = entryController.findByCriteria<TransactionEntry>(
      entryFilterController.transactionRange.value.start,
      entryFilterController.transactionRange.value.end,
      null,
    );

    return Scaffold(
      body: ConstrainedView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: DateRangeFilterSlider(onChanged: (values) {
                entryFilterController.transactionRange.value = values;
                entries.value =
                    entryController.findByCriteria<TransactionEntry>(
                  entryFilterController.transactionRange.value.start,
                  entryFilterController.transactionRange.value.end,
                  null,
                );
              }),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: OptionalTransactionsList(entries: entries),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
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
