import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryFilterController {
  final Rx<DateTimeRange> transactionRange = DateTimeRange(
    start: DateTime.utc(-271821, 04, 20),
    end: DateTime.utc(275760, 09, 13),
  ).obs;
  final Rx<RangeValues> dateRangeFilterValues = const RangeValues(-7, 1).obs;
}
