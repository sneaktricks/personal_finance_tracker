import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/services/services.dart';

class EntryController {
  final incomeService = Get.find<IncomeService>();
  final expenseService = Get.find<ExpenseService>();

  RxList<IncomeEntry> incomeEntries;
  RxList<ExpenseEntry> expenseEntries;

  List<TransactionEntry> get entries => [...incomeEntries, ...expenseEntries]
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  EntryController()
      : incomeEntries = <IncomeEntry>[].obs,
        expenseEntries = <ExpenseEntry>[].obs {
    incomeEntries.value = incomeService.entries;
    expenseEntries.value = expenseService.entries;
  }

  BigInt get incomeSum =>
      incomeEntries.map((e) => e.value).fold(BigInt.zero, (a, b) => a + b);
  BigInt get expenseSum =>
      expenseEntries.map((e) => e.value).fold(BigInt.zero, (a, b) => a + b);

  void addIncome(IncomeEntry entry) {
    incomeService.add(entry);
    incomeEntries.add(entry);
  }

  void addExpense(ExpenseEntry entry) {
    expenseService.add(entry);
    expenseEntries.add(entry);
  }

  void deleteExpense(ExpenseEntry entry) {
    expenseService.entries.removeWhere((e) => e.id == entry.id);
    expenseEntries.removeWhere((e) => e.id == entry.id);
  }

  void deleteIncome(IncomeEntry entry) {
    incomeService.entries.removeWhere((e) => e.id == entry.id);
    incomeEntries.removeWhere((e) => e.id == entry.id);
  }

  TransactionEntry? findById(String id) {
    return incomeEntries.firstWhereOrNull((e) => e.id == id) ??
        expenseEntries.firstWhereOrNull((e) => e.id == id);
  }

  List<T> findByCriteria<T extends TransactionEntry>(
      DateTime? minDate, DateTime? maxDate, List<String>? categories) {
    // Filter by type
    Iterable<T> filteredEntries = entries.whereType<T>();

    if (minDate != null) {
      filteredEntries =
          filteredEntries.where((e) => e.timestamp.isAfter(minDate));
    }
    if (maxDate != null) {
      filteredEntries =
          filteredEntries.where((e) => e.timestamp.isBefore(maxDate));
    }
    if (categories != null) {
      filteredEntries =
          filteredEntries.where((e) => categories.contains(e.category));
    }

    return filteredEntries.toList();
  }

  Map<String, BigInt> incomeByCategory() {
    final grouped = groupBy(incomeEntries, (e) => e.category);
    return grouped
        .map((k, v) => MapEntry(k, v.fold(BigInt.zero, (a, b) => a + b.value)));
  }

  Map<String, BigInt> expenseByCategory() {
    final grouped = groupBy(expenseEntries, (e) => e.category);
    return grouped
        .map((k, v) => MapEntry(k, v.fold(BigInt.zero, (a, b) => a + b.value)));
  }
}
