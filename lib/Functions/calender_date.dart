
import 'package:intl/intl.dart';

String viewDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today, ${DateFormat('dd MMM').format(date)}';
  } else {
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Yesterday, ${DateFormat('dd MMM').format(date)}';
    } else {
      return DateFormat('EEEE, dd MMM').format(date);
    }
  }
}

