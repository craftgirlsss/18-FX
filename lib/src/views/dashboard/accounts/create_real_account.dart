import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/create_real_account_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class CreateRealAccount extends StatefulWidget {
  const CreateRealAccount({super.key});

  @override
  State<CreateRealAccount> createState() => _CreateRealAccountState();
}

class _CreateRealAccountState extends State<CreateRealAccount> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Buat akun REAL", style: TextStyle(color: Colors.white))
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("Your money\nwork while you", style: TextStyle(color: Colors.black54, fontSize: 40), textAlign: TextAlign.center,),
                  Image.asset('assets/images/rest-text.png', width: size.width / 3),
                ],
              ),
              Image.asset('assets/images/rest.png'),
              CustomCupertinoButton.tint(
                onPressed: (){
                  Get.to(() => const CreateRealAccountWeb());
                  // alertError(
                  //   message: "Fitur masih dalam pengembangan",
                  //   onTap: (){
                  //     Get.back();
                  //   },
                  // );
                },
                iconData: Iconsax.card_add_outline,
                title: "Buat Akun Real Sekarang"
              )
            ],
          ),
        ),
      ),
    );
  }
}