import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textstyle.dart';

Container noRealAccountAvailable(context, {bool? withBorderColor = false}){
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: MediaQuery.of(context).size.width,
    decoration: withBorderColor == true ? BoxDecoration(
      border: Border.all(width: 0.3, color: Colors.white24),
      borderRadius: BorderRadius.circular(15),
      color: CupertinoColors.darkBackgroundGray,
    ) : null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty.png', gaplessPlayback: false, width: 150),
          // Lottie.asset('assets/images/no.images', frameRate: const FrameRate(60), repeat: false, width: 100),
          Text("You haven't real account", style: kDefaultTextStyleCustom(fontSize: 15),),
        ],
      ),
    );
}

Container noDemoAccountAvailable(context, {bool? withBorderColor = false}){
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: MediaQuery.of(context).size.width,
    decoration: withBorderColor == true ? BoxDecoration(
      border: Border.all(width: 0.3, color: Colors.white24),
      borderRadius: BorderRadius.circular(15),
      color: CupertinoColors.darkBackgroundGray,
    ) : null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty.png', gaplessPlayback: false, width: 150),
          Text("You haven't demo account", style: kDefaultTextStyleCustom(fontSize: 15),),
        ],
      ),
    );
}