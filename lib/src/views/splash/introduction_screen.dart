import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/helpers/api.dart';
import 'package:delapanbelasfx/src/helpers/permission_handler.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/helpers/url_launchers.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:get/get.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  AccountsController accountsController = Get.find();
  Future permissionFirebase(context)async{
    await FirebaseApi().initNotifications();
    permissionServiceCall(context);
  }

  @override
  void initState() {
    super.initState();
    permissionFirebase(context);
    accountsController.checkMyVersionApp().then((version) async {
      whatsNew(
        time: DateTime(2025, DateTime.april, 7),
        versionApp: version
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        // appBar: kDefaultAppBarTitle(),
        body: SafeArea(
          child : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: GlobalVariablesType.paddingLeft, right: GlobalVariablesType.paddingRight, top: GlobalVariablesType.paddingTop, bottom: GlobalVariablesType.paddingBottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(GlobalVariablesType.titleSplashScreen!, style: kDefaultTextStyleTitleAppBar()),
                        const SizedBox(height: 5),
                        SizedBox(height: GlobalVariablesType.height),
                        Text(GlobalVariablesType.descriptionSplashScreen!, style: kDefaultTextStyleSubtitleSplashScreen(color: GlobalVariablesType.mainColor)),
                        const SizedBox(height: 170),
                        Center(child: Image.asset('assets/images/ic_launcher.png', width: 150),)
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: kDefaultButtonLogin(
                            title: "Lanjutkan",
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);                     
                            })),
                        TextButton(
                          onPressed: () => launchUrls(GlobalVariablesType.termsAndConditions),
                          child: Text(GlobalVariablesType.termsAndConditionsText, style: const TextStyle(color: Colors.white, fontSize: 13)) )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}