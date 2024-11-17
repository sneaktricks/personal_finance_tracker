import 'package:intl/intl.dart';

final NumberFormat percentageFormat =
    NumberFormat.decimalPercentPattern(decimalDigits: 2);
final NumberFormat currencyFormat = NumberFormat.simpleCurrency();
final NumberFormat compactCurrencyFormat = NumberFormat.compactCurrency();

/// Formats the given number of [cents] in a compact manner.
/// Uses [compactCurrencyFormat] internally, but also handles
/// special cases where the number of currency units exceeds
/// 999T in magnitude.
String formatCompactCurrency(double cents) {
  final units = cents / 100;
  // Handle goofy balance (>999T in magnitude)
  if (units.abs() > 999e12) {
    return "${units < 0 ? '<' : '>'}${compactCurrencyFormat.format(units.sign * 999e12)}";
  }
  return compactCurrencyFormat.format(units);
}

final DateFormat dateFormat = DateFormat.yMMMMd();
