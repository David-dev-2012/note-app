import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  /// e.g. "Sun, Feb, 2025"
  static String formatNoteDate(DateTime date) {
    return DateFormat('EEE, MMM, yyyy').format(date);
  }

  /// e.g. "12:30 PM"
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// e.g. "Feb 2, 2025"
  static String formatShort(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// e.g. "Today", "Yesterday", or "Feb 2"
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final noteDay = DateTime(date.year, date.month, date.day);
    final diff = today.difference(noteDay).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return DateFormat('MMM d').format(date);
  }
}
