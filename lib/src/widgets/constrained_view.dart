import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/utils/breakpoint.dart'
    as breakpoint;
import 'package:personal_finance_tracker/src/widgets/navigation_rail.dart';

class ConstrainedView extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final bool omitNavRail;

  const ConstrainedView(
      {super.key,
      required this.child,
      this.maxWidth = breakpoint.maxWidth,
      this.omitNavRail = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Visibility(
            visible: breakpoint.widthToView(width) >= 1 && !omitNavRail,
            child: NavRail()),
        Expanded(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final c = constraints.copyWith(
                  maxWidth: min(constraints.maxWidth, maxWidth),
                );
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
