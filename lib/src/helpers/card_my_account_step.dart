import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/create_real_account.dart';
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
  TradingAccountController tradingAccountController = Get.find();
  RxString steps = "0".obs;
    
  @override
  Widget build(BuildContext context) {
    print("INI ID AKUN ${accountsController.userToken.value}");
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
        color: GlobalVariablesType.backgroundColor,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
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
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.name != null ? accountsController.detailTempModel.value!.response.personalDetail.name!.capitalize! : "Username", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.email ?? "username@email.com", style: const TextStyle(fontSize: 13, color: Colors.black54))),
                  Obx(() => Text(accountsController.detailTempModel.value?.response.personalDetail.phone ?? "+62", style: const TextStyle(fontSize: 13, color: Colors.black54))),
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
              border: Border.all(color: Colors.black12),
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
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
                        style: TextStyle(color: Colors.black54, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 14),
                        child: Text("Status Pendaftaran")
                      ),
                      DefaultTextStyle(
                          overflow: TextOverflow.clip,
                          style: const TextStyle(color: Colors.black45, fontFamily: "SF-Pro-Bold", fontWeight: FontWeight.normal, fontSize: 14),
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
                      tradingAccountController.getListAccountTrading().then((results) {
                        if(!results){
                          alertError(
                            message: tradingAccountController.responseMessage.value,
                            onTap: (){Navigator.pop(context);},
                            title: "Gagal"
                          );
                        }else{
                          // ignore: prefer_is_empty
                          if(tradingAccountController.listTradingAccount.value!.response.isEmpty){
                            tradingAccountController.createDemo().then((result){
                              if(result){
                                alertDialogCustomSuccess(
                                  onTap: (){
                                    tradingAccountController.getListAccountTrading();
                                    Navigator.pop(context);
                                  },
                                  message: tradingAccountController.responseMessage.value,
                                  textButton: "Kembali",
                                  title: "Berhasil"
                                );
                              }else{
                                alertError(
                                  message: tradingAccountController.responseMessage.value,
                                  onTap: (){Navigator.pop(context);},
                                  title: "Gagal"
                                );
                              }
                            });
                          }else{
                            if(tradingAccountController.listTradingAccount.value?.response.length != 0 || tradingAccountController.listTradingAccount.value?.response.length != null){
                              if(tradingAccountController.listTradingAccount.value!.response[0].type == "real" || tradingAccountController.listTradingAccount.value!.response[0].type == "demo"){
                                Get.to(() => const CreateRealAccount());
                              }else{
                                alertError(
                                  message: "Tidak ada akun real ataupun demo",
                                  onTap: (){Navigator.pop(context);},
                                  title: "Gagal"
                                );
                              }
                            }else{
                              tradingAccountController.createDemo().then((result){
                                if(result){
                                  alertDialogCustomSuccess(
                                    onTap: (){
                                      tradingAccountController.getListAccountTrading();
                                      Navigator.pop(context);
                                    },
                                    message: tradingAccountController.responseMessage.value,
                                    textButton: "Kembali",
                                    title: "Berhasil"
                                  );
                                }else{
                                  alertError(
                                    message: tradingAccountController.responseMessage.value,
                                    onTap: (){Navigator.pop(context);},
                                    title: "Gagal"
                                  );
                                }
                              });
                            }
                          }
                        }
                      });
                    },
                  child: Obx(() => tradingAccountController.isLoading.value ? const CupertinoActivityIndicator(color: Colors.black54) : const Text("Buat Akun Baru", style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center))
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