import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoListSectionInsertGroup extends StatelessWidget {
  final Color? separatorColor;
  final List<Widget>? children;
  final String? header;
  final String? footer;
  final Key? keyForm;
  const CustomCupertinoListSectionInsertGroup({super.key, this.children, this.header, this.footer, this.keyForm, this.separatorColor});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      key: keyForm,
      topMargin: 0,
      hasLeading: true,
      dividerMargin: 15,
      separatorColor: separatorColor ?? Colors.black26,
      footer: Text(footer ?? '', style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.normal, fontSize: 12),),
      header: Text(header != null ? header!.toUpperCase() : "HEADER", style: const TextStyle(fontSize: 15, color: CupertinoColors.white, fontWeight: FontWeight.normal),),
      margin: const EdgeInsets.all(15),
      backgroundColor: const Color.fromARGB(0, 141, 133, 133),
      children: children,
    );
  }
}