import 'dart:io';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/mainpage.dart';
import 'package:delapanbelasfx/src/views/splash/introduction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FailedVersionApp extends StatefulWidget {
  const FailedVersionApp({super.key});

  @override
  State<FailedVersionApp> createState() => _FailedVersionAppState();
}

class _FailedVersionAppState extends State<FailedVersionApp> {
  AccountsController accountsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DefaultTextStyle(
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                        child: Text("Your Version app is depreceted, please update for new version", textAlign: TextAlign.center)),
                  ),
                  SizedBox(
                      width: size.width / 2,
                      child: Platform.isAndroid ? OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: GlobalVariablesType.mainColor)
                        ),
                          label: const Text("Update via Play Store", style: TextStyle(color: Colors.black45)),
                          onPressed: (){
                            if (Platform.isAndroid || Platform.isIOS) {
                              final appId = Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
                              final url = Uri.parse(
                                Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
                              );
                              launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          }, icon: const Icon(Icons.android_sharp, color: GlobalVariablesType.mainColor)
                      ) : OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: GlobalVariablesType.mainColor)
                            ),
                            label: const Text("Update from App Store", style: TextStyle(color: Colors.white)),
                            onPressed: (){}, icon: const Icon(Icons.apple, color: GlobalVariablesType.mainColor)
                      )
                  ),

                  CupertinoButton(
                    onPressed: () async {
                      accountsController.checkMyVersionApp().then((version) async {
                        accountsController.compareVersionApp(version: version).then((success){
                          if(success){
                            Future.delayed(Duration.zero).then((value) async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              bool? wasLogin = prefs.getBool('login');
                              if(wasLogin == true){
                                accountsController.getUserInfo().then((result){
                                  if(result){
                                    Get.off(() => const MainPage());
                                  }else{
                                    alertError(title: "Gagal", message: accountsController.responseMessage.value, onTap: (){Navigator.pop(context);});
                                  }
                                });
                              }else{
                                Get.off(() => const IntroductionScreen());
                              }
                            });
                          }else{
                            Get.offAll(() => const FailedVersionApp());
                          }
                        });
                      });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.refresh_square_2_bold, color: Colors.white),
                        SizedBox(width: 5),
                        Text("Refresh", style: TextStyle(color: Colors.white)
                        ),
                      ],
                    ), 
                  )
                ],
              ),
            )
        )
    );
  }
}