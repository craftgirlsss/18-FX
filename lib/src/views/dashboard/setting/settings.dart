import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:delapanbelasfx/src/views/splash/introduction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/chats_v2.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/faq.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_password.dart';
import 'detail_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AccountsController accountsController = Get.find();
  TradingAccountController tradingAccountController = Get.put(TradingAccountController());
  String? appID;
  RxString appVersion = ''.obs;
  Future<String> getIDFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('player_id') ?? 'App ID Null';
  }
  
  @override
  void initState() {
    getIDFirebase().then((value) => setState(() {
      appID = value;
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarTitle(
        title: "Settings",
      ),
      body: ListView(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/ic_launcher.png'),
                ),
                const SizedBox(height: 10),
                Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.name != null ? accountsController.detailTempModel.value!.response.personalDetail.name!.capitalize! : "Username", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))),
                Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.email ?? "username@email.com", style: const TextStyle(fontSize: 13, color: Colors.black54))),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  width: size.width / 4,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.checkmark_circle, color: Colors.white, size: 17),
                      SizedBox(width: 5),
                      Text("Verified", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                listTile(
                  onPressed: (){
                    Get.to(() => const DetailProfile());
                  }
                ),
                listTile(
                  onPressed: (){
                    Get.to(() => const ChangePasswordPage());
                  },
                  name: "Ganti Kata Sandi",
                  icon: ZondIcons.lock_closed
                ),
                listTile(
                  onPressed: (){
                    Get.to(() => const FAQPage());
                  },
                  name: "Frequently Asking",
                  icon: ZondIcons.chat_bubble_dots
                ),
                listTile(
                  onPressed: (){
                    Get.to(() => const ChatsV2());
                  },
                  icon: Clarity.chat_bubble_solid,
                  name: "Customer Service"
                ),
                listTile(
                  onPressed: (){
                    alertError(
                      message: "Apakah anda yakin untuk keluar dari akun ini?",
                      title: "Keluar",
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('user_id');
                        prefs.remove('user_token');
                        prefs.remove('login');
                        prefs.remove('email');
                        prefs.remove('password');
                        Future.delayed(const Duration(seconds: 1), (){
                          Get.offAll(() => const IntroductionScreen());
                        });
                      }
                    );
                  },
                  icon: BoxIcons.bxs_exit,
                  name: "Keluar"
                ),
              ],
            ),
          )
        ],
      ),
    );
    /*
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarTitle(
        centerTitle: true,
        fontSize: 16,
        title: "My Information"
      ),
      body: SingleChildScrollView(
        padding: GlobalVariablesType.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              elevation: 1,
              child: ListTile(
                onTap: (){
                  Get.to(() => const DetailProfile());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                tileColor: CupertinoColors.darkBackgroundGray,
                leading: Obx(
                  () => Container(
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: accountsController.detailTempModel.value?.response.personalDetail.urlPhoto == "-" ? const DecorationImage(image: AssetImage('assets/images/ic_launcher.png')) : DecorationImage(image: NetworkImage(accountsController.detailTempModel.value!.response.personalDetail.urlPhoto!), fit: BoxFit.cover)
                    ),
                  ),
                ),
                title: Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.name ?? "Unknown", style: kDefaultTextStyleCustom(fontSize:14))),
                subtitle: Text(GlobalVariablesType.showProfil, style: kDefaultTextStyleButtonText(color: Colors.black54),),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 15),
            CupertinoListSection.insetGrouped(
              backgroundColor: Colors.transparent,
              additionalDividerMargin: 0,
              margin: const EdgeInsets.all(0),
              topMargin: 0,
              header: Text("Account settings",
                style: kDefaultTextStyleTitleAppBarBold(fontSize: 19)),
              hasLeading: false,
              children: [
                // CupertinoListTile.notched(
                //   backgroundColor: CupertinoColors.darkBackgroundGray,
                //   onTap: (){
                //     Get.to(() => const DepositAndWithdrawal());
                //   },
                //   trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                //   leading: const Icon(Bootstrap.clock_history, color: Colors.white, size: 20,),
                //   title: Text("History DP & WD", style: kDefaultTextStyleCustom(fontSize:14))),
                CupertinoListTile.notched(
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  onTap: (){
                    Get.to(() => const ChangePasswordPage());
                  },
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                  leading: const Icon(CupertinoIcons.pencil_ellipsis_rectangle, color: Colors.black),
                  title: Text("Change Password", style: kDefaultTextStyleCustom(fontSize:14))),
                CupertinoListTile.notched(
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  onTap: (){
                    Get.to(() => const FAQPage());
                  },
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                  leading: const Icon(CupertinoIcons.question_circle, color: Colors.black),
                  title: Text("FAQ", style: kDefaultTextStyleCustom(fontSize:14))),
                CupertinoListTile.notched(
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  onTap: (){
                    Get.to(() => const ChatsV2());
                  },
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                  leading: const Icon(Icons.support_agent, color: Colors.black),
                  title: Text("Chat Support", style: kDefaultTextStyleCustom(fontSize:14))),
                CupertinoListTile.notched(
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  onTap: (){
                    alertError(
                      message: "Apakah anda yakin untuk keluar dari akun ini?",
                      title: "Keluar",
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('user_id');
                        prefs.remove('user_token');
                        prefs.remove('login');
                        prefs.remove('email');
                        prefs.remove('password');
                        Future.delayed(const Duration(seconds: 1), (){
                          Get.off(() => const LoginPage());
                        });
                      }
                    );
                  },
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
                  leading: const Icon(Icons.exit_to_app_rounded, color: Colors.black),
                  title: Text("Sign Out", style: kDefaultTextStyleCustom(fontSize:14))),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: (){
                    whatsNew(
                      time: DateTime(2025, DateTime.april, 7),
                      versionApp: appVersion.value
                    );
                  },
                  child: Text("Lihat Apa yang baru di Versi Aplikasi $appVersion", style: kDefaultTextStyleCustom(color: Colors.white38, fontSize: 12))
                ),
              ),
            ),
          ],
        ),
      ),
    );
    */
  }

  CupertinoButton listTile({String? name, IconData? icon, Function()? onPressed}){
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon ?? Bootstrap.person_fill, color: GlobalVariablesType.mainColor),
                const SizedBox(width: 8),
                Text(name ?? "Personal Information", style: const TextStyle(color: GlobalVariablesType.mainColor),),
              ],
            ),
            const Icon(CupertinoIcons.arrow_right, color: GlobalVariablesType.mainColor)
          ],
        )
      ),
    );
  }
}