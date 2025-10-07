import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return formatter.format(value);
}

String formatDateFromMillis(int millis) {
  final date = DateTime.fromMillisecondsSinceEpoch(millis);
  final formatter = DateFormat('dd MMM yyyy', 'id_ID');
  return formatter.format(date);
}

