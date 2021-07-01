import 'package:intl/intl.dart';

String returnDate(int timeStamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  String suffixx = suffix(dateTime.day);
  String month = DateFormat.MMM().format(dateTime);

  return '${dateTime.day}$suffixx $month ${dateTime.year}';
}

String returnTime(int timeStamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return '${dateTime.hour}:'
      '${dateTime.minute.toString().length == 1 ? dateTime.minute.toString().padLeft(2, '0') : dateTime.minute} ';
}

String suffix(int day) {
  if (day % 10 == 1) {
    return 'st';
  } else if (day % 10 == 2) {
    return 'nd';
  } else if (day % 10 == 3) {
    return 'rd';
  } else {
    return 'th';
  }
}
