import 'package:uuid/uuid.dart';

abstract class TransactionEntry {
  final String id;
  final BigInt value;
  final String category;
  final DateTime timestamp;

  TransactionEntry(this.id, this.value, this.category, this.timestamp);

  TransactionEntry.create(this.value, this.category, this.timestamp)
      : id = const Uuid().v4();

  Map toJson() => {
        "id": id,
        "value": value,
        "category": category,
        "timestamp": timestamp,
      };
}

class IncomeEntry extends TransactionEntry {
  IncomeEntry(super.id, super.value, super.category, super.timestamp);
  IncomeEntry.create(super.value, super.category, super.timestamp)
      : super.create();

  factory IncomeEntry.fromJson(Map json) {
    return IncomeEntry(
        json["id"], json["value"], json["category"], json["timestamp"]);
  }
}

class ExpenseEntry extends TransactionEntry {
  ExpenseEntry(super.id, super.value, super.category, super.timestamp);
  ExpenseEntry.create(super.value, super.category, super.timestamp)
      : super.create();

  factory ExpenseEntry.fromJson(Map json) {
    return ExpenseEntry(
        json["id"], json["value"], json["category"], json["timestamp"]);
  }
}
