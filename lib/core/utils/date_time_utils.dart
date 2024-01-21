import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const DD_MM_YYYY = 'dd/MM/yyyy';
const YYYY_MM_DD = 'yyyy-mm-dd';

extension DateTimeExtension on DateTime {
  /// Return a string representing [date] formatted according to our locale
  String format([String pattern = YYYY_MM_DD, String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}
