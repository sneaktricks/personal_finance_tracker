import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:personal_finance_tracker/src/services/services.dart';

import 'src/app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<List>("income_storage");
  await Hive.openBox<List>("expense_storage");

  Get.lazyPut(() => NavigationController());
  Get.lazyPut(() => IncomeService());
  Get.lazyPut(() => ExpenseService());
  Get.lazyPut(() => EntryController());

  runApp(const MyApp());
}
