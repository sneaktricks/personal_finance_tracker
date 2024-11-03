import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat.simpleCurrency();
final NumberFormat compactCurrencyFormat = NumberFormat.compactCurrency();

String formatCompactCurrency(double cents) {
  final units = cents / 100;
  // Handle goofy balance (>999T in magnitude)
  if (units.abs() > 999e12) {
    return "${units < 0 ? '<' : '>'}${compactCurrencyFormat.format(units.sign * 999e12)}";
  }
  return compactCurrencyFormat.format(units);
}

final DateFormat dateFormat = DateFormat.yMMMMd();
