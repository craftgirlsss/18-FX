import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardMenuAccount extends StatefulWidget {
  const CardMenuAccount({super.key});

  @override
  State<CardMenuAccount> createState() => _CardMenuAccountState();
}

class _CardMenuAccountState extends State<CardMenuAccount> {
  AccountsController accountsController = Get.find();
  RxString steps = "0".obs;
    
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white38),
        color: GlobalVariablesType.backgroundColor,
        boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.name != null ? accountsController.detailTempModel.value!.response.personalDetail.name!.capitalize! : "Username", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.email ?? "username@email.com", style: const TextStyle(fontSize: 13, color: Colors.white54))),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.phone ?? "+62", style: const TextStyle(fontSize: 13, color: Colors.white54))),
                ],
              ),
              Image.asset('assets/images/ic_launcher.png', width: 60)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.white38),
              // color: Colors.white54,
              // boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(CupertinoIcons.info, color: Colors.black54),
                ),
                Flexible(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DefaultTextStyle(
                        overflow: TextOverflow.clip,
                        style: TextStyle(color: Colors.white60, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 14),
                        child: Text("Status Pendaftaran")
                      ),
                      DefaultTextStyle(
                          overflow: TextOverflow.clip,
                          style: const TextStyle(color: Colors.white54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 14),
                          child: Text("STEP : ${steps.value}")
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(5),
                      backgroundColor: GlobalVariablesType.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () {
                      
                    },
                  child: const Text("Buat Akun Baru", style: TextStyle(color: Colors.black54, fontSize: 12), textAlign: TextAlign.center)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}