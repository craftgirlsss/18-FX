import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/login/register_v2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/helpers/api.dart';
import 'package:delapanbelasfx/src/helpers/permission_handler.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  AccountsController accountsController = Get.find();
  PageController pageControllerPromo = PageController();
  Future permissionFirebase(context)async{
    await FirebaseApi().initNotifications();
    permissionServiceCall(context);
  }

  List image = [
    {
      'img': 'assets/images/1-3d.png',
      'text': "Raih Peluang Global, Investasi Forex Sekarang!",
      'color': GlobalVariablesType.mainColor,
    },
    {
      'img': 'assets/images/2-3d.png',
      'text': "Masa Depan Finansial Cerah? Mulai Investasi Forex Hari Ini!",
      'color': GlobalVariablesType.mainColor,
    },
    {
      'img': 'assets/images/trade.png',
      'text': "Tools Trading Lengkap di Genggaman Anda, Trading Jadi Mudah." ,
      'color': GlobalVariablesType.mainColor,
    }, 
  ];

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
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemCount: image.length,
              physics: const BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              controller: pageControllerPromo,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: size.width / 3),
                  width: size.width,
                  height: size.height,
                  color: image[index]['color'],
                  child: Column(
                    children: [
                      Text(image[index]['text'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,  color: Colors.white), textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width / 1.5,
                        height: size.width / 1.5,
                        child: Image.asset(image[index]['img'])),
                      const Spacer()
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: size.width / 6,
              child: SizedBox(
                width: size.width,
                height: 20,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: pageControllerPromo,
                    count: image.length,
                    effect: WormEffect(
                      dotHeight: 5,
                      dotWidth: size.width / 6,
                      dotColor: Colors.black12,
                      type: WormType.thinUnderground,
                      activeDotColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: size.width,
                height: size.width / 2,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width - 30,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: CupertinoColors.black,
                        onPressed: (){
                          Get.to(() => const RegisterAccountV2());
                        },
                        child: const Text("Daftar", style: TextStyle(color: Colors.white),), 
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: size.width - 30,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: CupertinoColors.white,
                        onPressed: (){
                          Get.to(() => const LoginPage());
                        },
                        child: const Text("Masuk", style: TextStyle(color: Colors.black),), 
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("You will be redirect to login page to sign in", style: TextStyle(color: Colors.black54, fontSize: 12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CupertinoButton(
                          onPressed: (){},
                          child: const Text("User Terms", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 12)),
                        ),
                        CupertinoButton(
                          onPressed: (){},
                          child: const Text("Privacy", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 12)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            )
          ],
        )
        /*
        SafeArea(
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
                        Text(GlobalVariablesType.titleSplashScreen, style: kDefaultTextStyleTitleAppBar()),
                        const SizedBox(height: 5),
                        SizedBox(height: GlobalVariablesType.height),
                        Text(GlobalVariablesType.descriptionSplashScreen, style: kDefaultTextStyleSubtitleSplashScreen(color: GlobalVariablesType.mainColor)),
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
                          child: const Text(GlobalVariablesType.termsAndConditionsText, style: TextStyle(color: GlobalVariablesType.mainColor, fontSize: 13)) )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        */
      ),
    );
  }
}