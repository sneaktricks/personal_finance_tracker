import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class DateRangeFilterSlider extends StatelessWidget {
  DateRangeFilterSlider({super.key, this.onChanged});

  final ValueChanged<DateTimeRange>? onChanged;
  final Rx<RangeValues> _currentRangeValues = const RangeValues(-7, 0).obs;
  final _formKey = GlobalKey<FormBuilderState>();

  String label(double value) {
    return switch (value) {
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

  DateTimeRange rangeValuesToDateTimeRange(RangeValues rv) {
    final start = switch (rv.start) {
      0 => DateTime.now(),
      -1 => DateTime.now().subtract(const Duration(days: 1)),
      -2 => DateTime.now().subtract(const Duration(days: 7)),
      -3 => DateTime.now().subtract(const Duration(days: 30)),
      -4 => DateTime.now().subtract(const Duration(days: 6 * 30)),
      -5 => DateTime.now().subtract(const Duration(days: 365)),
      -6 => DateTime.now().subtract(const Duration(days: 3 * 365)),
      -7 => DateTime.utc(-271821, 04, 20),
      _ => DateTime.utc(-271821, 04, 20)
    };

    final end = switch (rv.end) {
      0 => DateTime.now(),
      -1 => DateTime.now().subtract(const Duration(days: 1)),
      -2 => DateTime.now().subtract(const Duration(days: 7)),
      -3 => DateTime.now().subtract(const Duration(days: 30)),
      -4 => DateTime.now().subtract(const Duration(days: 6 * 30)),
      -5 => DateTime.now().subtract(const Duration(days: 365)),
      -6 => DateTime.now().subtract(const Duration(days: 3 * 365)),
      -7 => DateTime.utc(-271821, 04, 20),
      _ => DateTime.now(),
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
            max: 0,
            divisions: 7,
            initialValue: const RangeValues(-7, 0),
            labels: RangeLabels(
              label(_currentRangeValues.value.start.roundToDouble()),
              label(_currentRangeValues.value.end.roundToDouble()),
            ),
            decoration: const InputDecoration(
              label: Text("Transaction date"),
            ),
            onChanged: (values) {
              _currentRangeValues.value = values!;
              onChanged!(rangeValuesToDateTimeRange(values));
            },
            minValueWidget: (_) => Text(label(-7)),
            maxValueWidget: (_) => Text(label(0)),
            valueWidget: (_) {
              if (_currentRangeValues.value.start.roundToDouble() ==
                  _currentRangeValues.value.end.roundToDouble()) {
                return Text(
                    label(_currentRangeValues.value.start.roundToDouble()));
              }
              return Text(
                  "${label(_currentRangeValues.value.start.roundToDouble())} to ${label(_currentRangeValues.value.end.roundToDouble())}");
            },
          ),
        ));
  }
}
