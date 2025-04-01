import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static final List<String> timeMeeting810 = <String>[
    "08:00 WIB - 10:00 WIB",
    "10:00 WIB - 12:00 WIB",
    "12:00 WIB - 14:00 WIB",
    "14:00 WIB - 16:00 WIB",
    "18:00 WIB - 20:00 WIB",
    "20:00 WIB - 20:30 WIB",
  ];

  static final List<String> timeMeeting1012 = <String>[
    "10:00 WIB - 12:00 WIB",
    "12:00 WIB - 14:00 WIB",
    "14:00 WIB - 16:00 WIB",
    "18:00 WIB - 20:00 WIB",
    "20:00 WIB - 20:30 WIB",
  ];

  static final List<String> timeMeeting1214 = <String>[
    "12:00 WIB - 14:00 WIB",
    "14:00 WIB - 16:00 WIB",
    "18:00 WIB - 20:00 WIB",
    "20:00 WIB - 20:30 WIB",
  ];

  static final List<String> timeMeeting1416 = <String>[
    "14:00 WIB - 16:00 WIB",
    "18:00 WIB - 20:00 WIB",
    "20:00 WIB - 20:30 WIB",
  ];

  static final List<String> timeMeeting1820 = <String>[
    "18:00 WIB - 20:00 WIB",
    "20:00 WIB - 20:30 WIB",
  ];

  static final List<String> timeMeeting2030 = <String>[
    "20:00 WIB - 20:30 WIB",
  ];

  static showCupertino(context, {Widget? widget, double? height})async{
    await showCupertinoModalPopup<void>(
      context: context, 
      builder: (_){
        final size = MediaQuery.of(context).size;
        return Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          height: size.height * (height ?? 0.27),
          child: widget
        );
      },
    );
  }
}


class CupertinoDatePickers extends StatefulWidget {
  final CupertinoDatePickerMode? mode;
  final int? maxYear, minYear;
  final DateTime? initialDateTime, maxDate, minDate;
  final TextEditingController controller;
  const CupertinoDatePickers({super.key, required this.controller, this.maxDate, this.minDate, this.initialDateTime, this.maxYear, this.minYear, this.mode});

  @override
  State<CupertinoDatePickers> createState() => _CupertinoDatePickersState();
}

class _CupertinoDatePickersState extends State<CupertinoDatePickers> {

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: widget.mode ?? CupertinoDatePickerMode.date,
      maximumYear: widget.maxYear ?? 2006,
      minimumYear: widget.minYear ?? 1950,
      showDayOfWeek: true,
      use24hFormat: true,
      // maximumDate: widget.maxDate ?? DateTime(2006),
      // minimumDate: widget.minDate ?? DateTime(1950),
      initialDateTime: widget.initialDateTime ?? DateTime(2000),
      onDateTimeChanged: (value){
        setState(() {
          widget.controller.text = DateFormat('yyyy-MM-dd').format(value);
        });
      },
    );
  }
}