import 'package:intl/intl.dart';

//Used extensions so that I could het the desired date time format in my app
extension DateExt on DateTime {
  String get timeOnly => DateFormat('hh:mm').format(this);
  String get dateOnly => DateFormat('yyyy-MM-dd').format(this);
}
