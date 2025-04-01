import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'textstyle.dart';

ElevatedButton kDefaultButtonLogin({
  Color? textColor = Colors.black,
  Function()? onPressed, String? title, Color? backgroundColor}){
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: backgroundColor ?? GlobalVariablesType.mainColor,
      elevation: 0
    ), 
    child: Text(title ?? GlobalVariablesType.loginText!, style: kDefaultTextStyleButton(
      color: textColor
    )));
}


ElevatedButton kDefaultButtonLoginWithGoogle({Function()? onPressed, String? title, Color? backgroundColor}){
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: backgroundColor ?? GlobalVariablesType.mainColor,
      elevation: 0
    ), 
    child: Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/google.png', width: 20),
          // const Icon(IonIcons.logo_google, size: 18, color: Colors.black54),
          const SizedBox(width: 10),
          Text(title ?? GlobalVariablesType.loginText!, style: kDefaultTextStyleButton(color: Colors.black54)),
        ],
      ),
    ));
}


class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromRGBO(255,215,0, 1), Color.fromARGB(255, 123, 118, 18)]),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}

class CustomCupertinoButton {
  static tint({Function()? onPressed, String? title, IconData? iconData}){
    return CupertinoButton(
      borderRadius: BorderRadius.circular(50),
      color: const Color.fromRGBO(25, 39, 68, 1),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(iconData ?? CupertinoIcons.play_arrow_solid, color: const Color.fromRGBO(75, 131, 252, 1)),
          Icon(iconData ?? CupertinoIcons.play_arrow_solid, color: Colors.white60, size: 20),
          const SizedBox(width: 3),
          // Text(title ?? "Button", style: const TextStyle(fontSize: 15, color: Color.fromRGBO(75, 131, 252, 1), fontFamily: "SFPro-Medium")),
          Text(title ?? "Button", style: const TextStyle(fontSize: 15, color: Colors.white60, fontFamily: "SFPro-Medium")),
        ],
      ),
    );
  }
}