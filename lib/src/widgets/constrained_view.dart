import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_rail.dart';

class ConstrainedView extends StatelessWidget {
  final Widget child;
  const ConstrainedView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Visibility(visible: widthToView(width) >= 1, child: NavRail()),
        Expanded(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final c = constraints.copyWith(
                    maxWidth: min(constraints.maxWidth, maxWidth));
                return ConstrainedBox(
                  constraints: c,
                  child: child,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
