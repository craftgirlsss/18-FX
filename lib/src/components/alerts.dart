import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:lottie/lottie.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

AccountsController accountsController = Get.find();

alertDialogSignOut(context){
  AccountsController accountsController = Get.find();
  return Get.defaultDialog(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    radius: 30,
    barrierDismissible: true,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/close.json', repeat: false),
        const SizedBox(height: 10),
        Text("Sign Out", style: kDefaultTextStyleTitleAppBar(fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        Text("Are you sure to sign out from your account?", style: kDefaultTextStyleTitleAppBar(fontSize: 13, fontWeight: FontWeight.normal),)
      ],
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            backgroundColor: Colors.red
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            accountsController.emailTemp.value == "";
            accountsController.passwordTemp.value == "";
            prefs.remove('id');
            prefs.remove('login');
            prefs.remove('email');
            prefs.remove('password');
            prefs.remove('loginWithGoogle');
            prefs.remove('id_trading');
            prefs.remove('tokenID');
            Future.delayed(const Duration(seconds: 1), (){
              Get.off(() => const LoginPage());
            });
          }, 
        child: Text("Yes", style: kDefaultTextStyleCustom(color: Colors.white
        ))),
      ),
    ]
  );
}

alertDialogSuccess(Function()? onTap){
  return Get.defaultDialog(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/success.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        Text("Berhasil", style: kDefaultTextStyleTitleAppBar(fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        const Text("Berhasil membuat akun. Silahkan cek pesan masuk pada nomor HP yang anda daftarkan sebelumnya", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white38), textAlign: TextAlign.center)
      ],
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            backgroundColor: Colors.green
          ),
          onPressed: onTap, 
        child: Text("Lanjutkan", style: kDefaultTextStyleCustom(color: Colors.white
        ))),
      ),
    ]
  );
}

alertDialogCustomSuccess({Function()? onTap, String? message, String? title, String? textButton}){
  return Get.defaultDialog(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/success.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        Text(title ?? "Berhasil", style: kDefaultTextStyleTitleAppBar(fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        Text(message ?? "Berhasil", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white38), textAlign: TextAlign.center)
      ],
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            backgroundColor: Colors.green
          ),
          onPressed: onTap, 
        child: Text(textButton ?? "Lanjutkan", style: kDefaultTextStyleCustom(color: Colors.white
        ))),
      ),
    ]
  );
}

alertDialogCustomInfo({Function()? onTap, String? message, String? title, String? textButton}){
  return Get.defaultDialog(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        const Icon(CupertinoIcons.info, size: 60, color: Colors.white70),
        const SizedBox(height: 10),
        Text(title ?? "Berhasil", style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        Text(message ?? "Berhasil", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white38), textAlign: TextAlign.center)
      ],
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            backgroundColor: Colors.green
          ),
          onPressed: onTap, 
        child: Text(textButton ?? "Lanjutkan", style: kDefaultTextStyleCustom(color: Colors.white
        ))),
      ),
    ]
  );
}

alertError({Function()? onTap, String? message, String? title}){
  return Get.defaultDialog(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/close.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        Text(title ?? "Gagal", style: kDefaultTextStyleTitleAppBar(fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        Text(message ?? "Galat", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white38), textAlign: TextAlign.center)
      ],
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 5,
            backgroundColor: Colors.green
          ),
          onPressed: onTap, 
        child: Text("Paham", style: kDefaultTextStyleCustom(color: Colors.white
        ))),
      ),
    ]
  );
}