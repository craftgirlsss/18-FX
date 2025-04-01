import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/chats_v2.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/faq.dart';
import 'package:delapanbelasfx/src/views/login/register_v2.dart';
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
  String? appID;
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
    final size = MediaQuery.of(context).size;
    return Obx(() => accountsController.skipToDashboard.value
      ? Container(
          width: size.width,
          height: size.height,
          color: GlobalVariablesType.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("You are not logged in, please log in first to be able to use all available features.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width / 2,
                child: ElevatedButton(onPressed: (){
                  Get.back();
                }, child: const Text("Login")),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: size.width / 2,
                child: ElevatedButton(onPressed: (){
                  Get.back();
                  Get.to(() => const RegisterAccountV2());
                }, child: const Text("Register")),
              ),
            ],
          ),
      ) : Scaffold(
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
                    subtitle: Text(GlobalVariablesType.showProfile, style: kDefaultTextStyleButtonText(color: Colors.white),),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.white),
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
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                      leading: const Icon(CupertinoIcons.pencil_ellipsis_rectangle, color: Colors.white),
                      title: Text("Change Password", style: kDefaultTextStyleCustom(fontSize:14))),
                    CupertinoListTile.notched(
                      backgroundColor: CupertinoColors.darkBackgroundGray,
                      onTap: (){
                        Get.to(() => const FAQPage());
                      },
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                      leading: const Icon(CupertinoIcons.question_circle, color: Colors.white),
                      title: Text("FAQ", style: kDefaultTextStyleCustom(fontSize:14))),
                    CupertinoListTile.notched(
                      backgroundColor: CupertinoColors.darkBackgroundGray,
                      onTap: (){
                        Get.to(() => const ChatsV2());
                      },
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                      leading: const Icon(Icons.support_agent, color: Colors.white),
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
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white),
                      leading: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
                      title: Text("Sign Out", style: kDefaultTextStyleCustom(fontSize:14))),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      Text("App Version 1.0.0+1", style: kDefaultTextStyleCustom(color: Colors.white38, fontSize: 15)),
                      // GestureDetector(
                      //   onLongPress: ()async{
                      //     await Clipboard.setData(
                      //       ClipboardData(text: appID!)
                      //     );
                      //   },
                      //   child: Tooltip(
                      //     triggerMode: TooltipTriggerMode.longPress,
                      //     message: "ID App Copied",
                      //     showDuration: const Duration(seconds: 2),
                      //     child: Text("App ID $appID", style: kDefaultTextStyleCustom(color: Colors.white38, fontSize: 12)))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}