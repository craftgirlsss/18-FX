import 'package:flutter/cupertino.dart';

void showCupertinoActionSheet(BuildContext context, {
  String? title,
  String? message,
  List<CupertinoActionSheetAction>? cupertinoActionSheet
}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title ?? ''),
        message: Text(message ?? ''),
        actions: cupertinoActionSheet,
      ),
    );
  }


  void showActionSheet(context, {
    String? title,
    List<Widget>? list,
    String? message
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title ?? 'Choose'),
        cancelButton: CupertinoActionSheetAction(onPressed: (){}, isDestructiveAction: true, child: const Text("Batal")),
        message: Text(message ?? 'Please choose another one'),
        actions: list
      ),
    );
  }