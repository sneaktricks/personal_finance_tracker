import 'package:flutter/material.dart';

class AnimatedCurrency extends ImplicitlyAnimatedWidget {
  final double value;
  final Widget Function(double) builder;

  const AnimatedCurrency({
    super.key,
    required this.value,
    required super.duration,
    super.curve = Curves.easeOut,
    required this.builder,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCurrencyState();
}

class _AnimatedCurrencyState extends AnimatedWidgetBaseState<AnimatedCurrency> {
  Tween<double> _tween = Tween(begin: 0, end: 0);

  _AnimatedCurrencyState() {
    _tween = Tween(begin: 0, end: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_tween.evaluate(animation));
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween =
        visitor(_tween, widget.value, (dynamic value) => Tween(begin: value))
            as Tween<double>;
  }
}
