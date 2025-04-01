import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AnnotatedRegion defaultAnnotatedRegion({Widget? child}){
  return  AnnotatedRegion(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black
    ),
    child: child!
  );
}