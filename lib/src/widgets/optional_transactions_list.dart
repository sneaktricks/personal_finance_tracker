import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/widgets/transactions_list.dart';

/// Conditionally displays a [ListView] of given transaction entries,
/// or a special view if the entry list is empty.
class OptionalTransactionsList extends StatelessWidget {
  final RxList<TransactionEntry> entries;

  const OptionalTransactionsList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Obx(() => entries.isEmpty
        ? const Column(
            children: [
              SizedBox(height: 40),
              Icon(
                Icons.list,
                size: 70,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Text(
                "No transaction entries that match the filter criteria",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                "Navigate to Add Entry to create an entry, or change filter criteria",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          )
        : TransactionsList(entries: entries));
  }
}
