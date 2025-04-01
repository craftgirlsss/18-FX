import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

class RejectedPage extends StatefulWidget {
  const RejectedPage({super.key});

  @override
  State<RejectedPage> createState() => _RejectedPageState();
}

class _RejectedPageState extends State<RejectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarGoBackOnly(context),
      body: SingleChildScrollView(
        padding: GlobalVariablesType.defaultPadding,
        child: Column(
          children: [
            Image.asset('assets/images/sad.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your have been banned!", textAlign: TextAlign.center, style: kDefaultTextStyleCustom(fontSize: 17)),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Please call our service ",
                style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal,fontSize: 13),
                children:[
                  TextSpan(
                    text: "(021) 3192 4744", style: kDefaultTextStyleCustom(color: CupertinoColors.activeBlue,fontSize: 13),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // print('Tap Here onTap')
                      },  
                  ),
                  TextSpan(text: " to get more informations", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal,fontSize: 13)),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: kDefaultButtonLogin(
                onPressed: (){
                  Navigator.pop(context);
                },
                title: "Go Back"
              ),
            )
          ],
        ),
      ),
    );
  }
}