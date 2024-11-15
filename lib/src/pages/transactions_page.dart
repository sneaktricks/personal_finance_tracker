import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/utils/formatters.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';
import 'package:personal_finance_tracker/src/widgets/date_range_filter_slider.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class TransactionsPage extends StatelessWidget {
  TransactionsPage({super.key});

  final entryController = Get.find<EntryController>();
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var entries = entryController.entries.obs;
    return Scaffold(
      body: ConstrainedView(
        child: Column(
          children: [
            DateRangeFilterSlider(onChanged: (values) {}),
            Expanded(
              child: Obx(
                () => ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(currencyFormat
                            .format(entries[index].value.toDouble() / 100)),
                        leading:
                            Icon(categoryIdToIcon[entries[index].category]),
                        subtitle: Text(
                            "${categoryIdToName[entries[index].category] ?? 'Unknown'} • ${dateFormat.format(entries[index].timestamp)}"),
                        hoverColor: Theme.of(context).hoverColor,
                        onTap: () =>
                            Get.toNamed("/transactions/${entries[index].id}"),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: entries.length),
              ),
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
