import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_filter_controller.dart';

/// Slider widget that is used to filter transaction entries by inception date.
class DateRangeFilterSlider extends StatelessWidget {
  DateRangeFilterSlider({super.key, this.onChanged});

  final _entryFilterController = Get.find<EntryFilterController>();

  final ValueChanged<DateTimeRange>? onChanged;
  final _formKey = GlobalKey<FormBuilderState>();

  /// Converts internal range value to label representing
  /// a point in a [DateTimeRange].
  String label(double value) {
    return switch (value) {
      1 => "future",
      0 => "now",
      -1 => "-1d",
      -2 => "-1w",
      -3 => "-1m",
      -4 => "-6m",
      -5 => "-1y",
      -6 => "-3y",
      -7 => "-∞",
      _ => "?",
    };
  }

  /// Converts a given [RangeValues] object into a [DateTimeRange].
  DateTimeRange rangeValuesToDateTimeRange(RangeValues rv) {
    final start = switch (rv.start) {
      1 => DateTime.utc(275760, 09, 13),
      0 => DateTime.now(),
      -1 => DateTime.now().subtract(const Duration(days: 1)),
      -2 => DateTime.now().subtract(const Duration(days: 7)),
      -3 => DateTime.now().subtract(const Duration(days: 30)),
      -4 => DateTime.now().subtract(const Duration(days: 6 * 30)),
      -5 => DateTime.now().subtract(const Duration(days: 365)),
      -6 => DateTime.now().subtract(const Duration(days: 3 * 365)),
      -7 => DateTime.utc(-271821, 04, 20),
      _ => DateTime.utc(-271821, 04, 20),
    };

    final end = switch (rv.end) {
      1 => DateTime.utc(275760, 09, 13),
      0 => DateTime.now(),
      -1 => DateTime.now().subtract(const Duration(days: 1)),
      -2 => DateTime.now().subtract(const Duration(days: 7)),
      -3 => DateTime.now().subtract(const Duration(days: 30)),
      -4 => DateTime.now().subtract(const Duration(days: 6 * 30)),
      -5 => DateTime.now().subtract(const Duration(days: 365)),
      -6 => DateTime.now().subtract(const Duration(days: 3 * 365)),
      -7 => DateTime.utc(-271821, 04, 20),
      _ => DateTime.utc(275760, 09, 13),
    };

    return DateTimeRange(
      start: start,
      end: end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Obx(
          () => FormBuilderRangeSlider(
            name: "date_range",
            min: -7,
            max: 1,
            divisions: 8,
            initialValue: _entryFilterController.dateRangeFilterValues.value,
            labels: RangeLabels(
              label(_entryFilterController.dateRangeFilterValues.value.start
                  .roundToDouble()),
              label(_entryFilterController.dateRangeFilterValues.value.end
                  .roundToDouble()),
            ),
            decoration: const InputDecoration(
              label: Text("Transaction Interval"),
              helperText: "Select time period to filter transactions",
            ),
            onChanged: (values) {
              _entryFilterController.dateRangeFilterValues.value = values!;
              onChanged!(rangeValuesToDateTimeRange(values));
            },
            minValueWidget: (_) => Text(label(-7)),
            maxValueWidget: (_) => Text(label(1)),
            valueWidget: (_) {
              if (_entryFilterController.dateRangeFilterValues.value.start
                      .roundToDouble() ==
                  _entryFilterController.dateRangeFilterValues.value.end
                      .roundToDouble()) {
                return Text(label(_entryFilterController
                    .dateRangeFilterValues.value.start
                    .roundToDouble()));
              }
              return Text(
                  "${label(_entryFilterController.dateRangeFilterValues.value.start.roundToDouble())} to ${label(_entryFilterController.dateRangeFilterValues.value.end.roundToDouble())}");
            },
          ),
        ));
  }
}
