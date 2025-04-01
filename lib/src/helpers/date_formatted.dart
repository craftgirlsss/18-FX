import 'package:intl/intl.dart';

class DateFormatted {
  static String formattedDate({String? date}){
    return DateFormat("dd MMM yyyy").format(DateTime.parse(date!));
  }

  static String formattedTime({String? date}){
    return DateFormat().add_jm().format(DateTime.parse(date!));
  }
}