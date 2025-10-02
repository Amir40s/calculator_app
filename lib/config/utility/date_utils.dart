import 'package:intl/intl.dart';

class MyDateUtils {
  /// Current date as DateTime
  static DateTime now() => DateTime.now();

  /// Current date in dd/MM/yyyy
  static String formatDdMmYyyy(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  /// Current date in yyyy-MM-dd (e.g. 2024-05-10)
  static String formatYyyyMmDd(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  /// Format with full month name (e.g. 10 May 2024)
  static String formatDdMonthYyyy(DateTime date) => DateFormat('d MMMM yyyy').format(date);

  /// Format with weekday (e.g. Friday, 10 May 2024)
  static String formatWithWeekday(DateTime date) => DateFormat('EEEE, d MMMM yyyy').format(date);

  /// Format with time (e.g. 10 May 2024, 5:30 PM)
  static String formatDateTime(DateTime date) => DateFormat('d MMM yyyy, h:mm a').format(date);

  /// Format for file or ID naming (e.g. 20240510_173000)
  static String formatForId(DateTime date) => DateFormat('yyyyMMdd_HHmmss').format(date);

  /// Only time (e.g. 5:30 PM)
  static String formatTimeOnly(DateTime date) => DateFormat('h:mm a').format(date);

  /// Only month and year (e.g. May 2024)
  static String formatMonthYear(DateTime date) => DateFormat('MMMM yyyy').format(date);

  /// Custom format
  static String formatCustom(DateTime date, String pattern) => DateFormat(pattern).format(date);

  /// Parse string to DateTime from given pattern
  static DateTime parse(String dateStr, String pattern) => DateFormat(pattern).parse(dateStr);
}
