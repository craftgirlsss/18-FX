import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailContrller = TextEditingController();
  AccountsController accountsController = Get.find();

  @override
  void dispose() {
    emailContrller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: GlobalVariablesType.backgroundColor,
            appBar: kDefaultAppBarGoBackOnly(context),
            body: ListView(
              padding: GlobalVariablesType.defaultPadding,
              children: [
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ic_launcher.png', width: size.width / 6, height: size.width / 6),
                    const SizedBox(height: 15),
                    Text("Lupa Kata Sandi?", style: kDefaultTextStyleSubtitleSplashScreen()),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: size.width / 1.5,
                      child: const Text("Inputkan alamat email yang sudah didaftarkan sebelumnya pada platform 18 FX", style: TextStyle(color: Colors.white38), textAlign: TextAlign.center,)),
                  ],
                ),
                const SizedBox(height: 15),
                EmailTextField(
                  hintText: "Input your email",
                  labelText: "Email",
                  controller: emailContrller,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => kDefaultButtonLogin(
                      title: "Konfirmasi",
                      onPressed: accountsController.isLoading.value == true ? (){} : () async {
                        if(await accountsController.forgot()){
                          alertDialogCustomSuccess(
                            onTap: (){
                              Get.off(() => const LoginPage());
                            },
                            message: accountsController.responseMessage.value,
                            title: "Sukses",
                            textButton: "Kembali"
                          );
                        }else{
                          alertError(
                            message: accountsController.responseMessage.value,
                            onTap: (){
                              Navigator.pop(context);
                            },
                            title: "Gagal"
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() => accountsController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}