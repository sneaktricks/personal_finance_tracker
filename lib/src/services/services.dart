import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:personal_finance_tracker/src/models/models.dart';

/// Manages income entries
class IncomeService {
  final storage = Hive.box<List>("income_storage");
  final key = "entries";

  List<IncomeEntry> get entries => storage.containsKey(key)
      ? [...?storage.get(key)].map((e) => IncomeEntry.fromJson(e)).toList()
      : [];

  void add(IncomeEntry entry) {
    final newEntries = entries..add(entry);
    storage.put(key, newEntries.map((e) => e.toJson()).toList());
  }

  BigInt get sum {
    if (!storage.containsKey(key)) {
      return BigInt.zero;
    }
    return storage
        .get(key)!
        .map((e) => IncomeEntry.fromJson(e).value)
        .fold(BigInt.zero, (a, b) => a + b);
  }
}

/// Manages expense entries
class ExpenseService {
  final storage = Hive.box<List>("expense_storage");
  final key = "entries";

  List<ExpenseEntry> get entries => storage.containsKey(key)
      ? [...?storage.get(key)].map((e) => ExpenseEntry.fromJson(e)).toList()
      : [];

  void add(ExpenseEntry entry) {
    final newEntries = entries..add(entry);
    storage.put(key, newEntries.map((e) => e.toJson()).toList());
  }

  BigInt get sum {
    if (!storage.containsKey(key)) {
      return BigInt.zero;
    }
    return storage
        .get(key)!
        .map((e) => ExpenseEntry.fromJson(e).value)
        .fold(BigInt.zero, (a, b) => a + b);
  }
}
