import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:lottie/lottie.dart';

Widget floatingLoading() {
  return Container(
    color: Colors.black.withOpacity(0.7),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/json/candle-animation.json', width: 40),
          DefaultTextStyle(
              style: kDefaultTextStyleCustom(), child: const Text("Loading..."))
        ],
      ),
    ),
  );
}