extension DateTimeFormat on DateTime {
  String get toHourAndMinute {
    return '${hour.toString()} : ${minute.toString()}';
  }
}
