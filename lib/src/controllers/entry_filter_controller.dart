import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryFilterController {
  final Rx<DateTimeRange> transactionRange =
      DateTimeRange(start: DateTime.utc(-271821, 04, 20), end: DateTime.now())
          .obs;
  final Rx<RangeValues> dateRangeFilterValues = const RangeValues(-7, 0).obs;
}
