import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/mainpage.dart';
import 'package:delapanbelasfx/src/views/splash/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/failed_version_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  AccountsController accountsController = Get.put(AccountsController());

  @override
  void initState() {
    super.initState();
    accountsController.checkMyVersionApp().then((version) async {
      print("Ini versi aplikasi => $version");
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/ic_launcher.png', width: 150),
            ],
          ),
        ),
      ),
    );
  }
}