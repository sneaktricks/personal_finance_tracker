import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class AddEntryPage extends StatelessWidget {
  AddEntryPage({super.key});

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ConstrainedView(
        child: Column(children: [
          const Text("What type of entry shall we add?"),
          FilledButton.icon(
            onPressed: () => Get.toNamed("/add-entry/income"),
            label: const Text("Income"),
            icon: const Icon(Icons.monetization_on),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
          ),
          FilledButton.icon(
            onPressed: () => Get.toNamed("/add-entry/expense"),
            label: const Text("Expense"),
            icon: const Icon(Icons.credit_card),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
            ),
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text("Add Entry"),
      ),
      bottomNavigationBar: widthToView(width) < 1 ? NavBar() : null,
    );
  }
}
