import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

GestureDetector iconCircleWithImage({Function()? onTap, String? title, String? assetImageURL, bool? withImage = true, IconData? icons}){
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: withImage! ? DecorationImage(image: AssetImage(assetImageURL ?? 'assets/images/ic_launcher.png')) : null
          ),
          child: withImage == false ? Icon(icons, color: Colors.black) : null,
        ),
        const SizedBox(height: 5),
        Text(title ?? "Unknown", style: kDefaultTextStyleCustom(),)
      ],
    ),
  );
}