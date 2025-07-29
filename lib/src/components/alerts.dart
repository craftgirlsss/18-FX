import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:intl/intl.dart';
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
    backgroundColor: GlobalVariablesType.backgroundColor,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/success.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        const Text("Berhasil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
        const SizedBox(height: 5),
        const Text("Berhasil membuat akun. Silahkan cek pesan masuk pada nomor HP yang anda daftarkan sebelumnya", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black45), textAlign: TextAlign.center)
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
    backgroundColor: GlobalVariablesType.backgroundColor,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/success.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        Text(title ?? "Berhasil", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
        const SizedBox(height: 5),
        Text(message ?? "Berhasil", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black45), textAlign: TextAlign.center)
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
    backgroundColor: GlobalVariablesType.backgroundColor,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        const Icon(CupertinoIcons.info, size: 60, color: Colors.black45),
        const SizedBox(height: 10),
        Text(title ?? "Berhasil", style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        Text(message ?? "Berhasil", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black45), textAlign: TextAlign.center)
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
    backgroundColor: CupertinoColors.white,
    radius: 30,
    barrierDismissible: false,
    title: "",
    content: Column(
      children: [
        Lottie.asset('assets/json/close.json', repeat: true,frameRate: const FrameRate(50)),
        const SizedBox(height: 10),
        Text(title ?? "Gagal", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
        const SizedBox(height: 5),
        Text(message ?? "Galat", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black45), textAlign: TextAlign.center)
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

whatsNew({String? versionApp, DateTime? time}){
  Get.defaultDialog(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    radius: 20,
    titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
    backgroundColor: Colors.white,
    confirm: TextButton(
      onPressed: (){
        Get.back();
      },
      child: const Text("OK", style: TextStyle(color: Colors.black54),)
    ),
    title: "What's New Version $versionApp\n${DateFormat('MMMM, dd yyyy').format(time!)}",
    titleStyle: const TextStyle(color: Colors.black45, fontSize: 15),
    content: const Text("""
1. Menambah fitur pembuatan akun Demo pada tab Accounts
2. Halaman awal pembuaan akun Real, jika anda sudah memiliki akun Demo, maka anda akan diarahkan ke halaman awal untuk pembuatan akun Real.
2. Icon beranda baru pada halaman setelah login berhasil
3. Halaman Detail News ketika anda mengklik daftar news pada tab Home pada section News Sentiment
4. Halaman Detail Akun Real, Tap pada card akun real pada tab akun, maka anda akan diarahkan ke halaman detail tentang Real Akun,
5. Pop up what's new setiap ada update terbaru
""", style: TextStyle(color: Colors.black38, fontSize: 13))
    );
  }