import 'package:intl/intl.dart';

String convertTimestampToDateFormat(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);

  String formattedDate = DateFormat('d MMM y').format(dateTime);

  return formattedDate;
}
