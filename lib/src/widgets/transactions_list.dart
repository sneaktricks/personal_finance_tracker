import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';

/// Displays given list of transaction entries in a [ListView].
class TransactionsList extends StatelessWidget {
  final RxList<TransactionEntry> entries;

  const TransactionsList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(currencyFormat.format(
                  (entries[index] is ExpenseEntry ? -1 : 1) *
                      entries[index].value.toDouble() /
                      100)),
              leading: Icon(categoryIdToIcon[entries[index].category]),
              subtitle: Text(
                  "${categoryIdToName[entries[index].category] ?? 'Unknown'} • ${dateFormat.format(entries[index].timestamp)}"),
              hoverColor: Theme.of(context).hoverColor,
              onTap: () => Get.toNamed("/transactions/${entries[index].id}"),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: entries.length),
    );
  }
}
