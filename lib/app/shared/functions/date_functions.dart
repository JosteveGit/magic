import 'package:magic/app/shared/functions/string_functions.dart';

String getMonth(int monthNumber, {bool capitalized = false}) {
  late String month;
  switch (monthNumber) {
    case 1:
      month = "january";
      break;
    case 2:
      month = "february";
      break;
    case 3:
      month = "march";
      break;
    case 4:
      month = "april";
      break;
    case 5:
      month = "may";
      break;
    case 6:
      month = "june";
      break;
    case 7:
      month = "july";
      break;
    case 8:
      month = "august";
      break;
    case 9:
      month = "september";
      break;
    case 10:
      month = "october";
      break;
    case 11:
      month = "november";
      break;
    case 12:
      month = "december";
      break;
  }
  if (capitalized) {
    return capitalize(month);
  }
  return month;
}

String stringifyDate(DateTime dateTime) {
  return "${zeroPrefixNumber(dateTime.day)}/${zeroPrefixNumber(dateTime.month)}/${dateTime.year}";
}

String formatDate(DateTime dateTime) {
  return "${zeroPrefixNumber(dateTime.day)} ${getMonth(dateTime.month, capitalized: true)} ${dateTime.year}, ${zeroPrefixNumber(dateTime.hour)}:${zeroPrefixNumber(dateTime.minute)} ";
}

String formatDateOnly(DateTime dateTime) {
  return "${zeroPrefixNumber(dateTime.day)}, ${getMonth(dateTime.month, capitalized: true)} ${dateTime.year}";
}

String formatTimeOnly(DateTime dateTime) {
  return "${zeroPrefixNumber(dateTime.hour)}:${zeroPrefixNumber(dateTime.minute)} ";
}

DateTime dateTimeToUTC(DateTime dateTime) {
  return DateTime.utc(
    dateTime.year,
    dateTime.month,
    dateTime.day,
  );
}

bool isThisDateWithinProvidedRange(
  DateTime dateTime, {
  required DateTime startDate,
  required DateTime endDate,
}) {
  final utcDateTime = dateTimeToUTC(dateTime);
  final utcStartDate = dateTimeToUTC(startDate);
  final utcEndDate = dateTimeToUTC(endDate);

  final startDateCondition = utcDateTime.isAtSameMomentAs(utcStartDate) ||
      utcDateTime.isAfter(utcStartDate);
  final endDateCondition = utcDateTime.isAtSameMomentAs(utcEndDate) ||
      utcDateTime.isBefore(utcEndDate);

  return startDateCondition && endDateCondition;
}

int getLastDayOfMonth(DateTime date) {
  int year = date.year;
  int month = date.month;
  final thirtyMonths = [4, 6, 9, 11];
  int februaryLastDate = 28;
  if (year % 4 == 0) {
    februaryLastDate = 29;
  }
  if (thirtyMonths.contains(month)) {
    return 30;
  } else if (month == 2) {
    return februaryLastDate;
  }
  return 31;
}

DateTime lastDayOfTheMonth() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, getLastDayOfMonth(now));
}

DateTime firstDayOfTheMonth() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}
