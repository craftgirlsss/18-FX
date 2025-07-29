import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:delapanbelasfx/src/helpers/card_account_demo.dart';
import 'package:delapanbelasfx/src/helpers/card_account_real.dart';
import 'package:delapanbelasfx/src/helpers/card_my_account_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsV2 extends StatefulWidget {
  const AccountsV2({super.key});

  @override
  State<AccountsV2> createState() => _AccountsV2State();
}

class _AccountsV2State extends State<AccountsV2> {

  TradingAccountController tradingAccountController = Get.put(TradingAccountController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: kDefaultAppBarTitle(
          title: "Accounts",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await tradingAccountController.getListAccountTrading().then((result){
              if(!result) Get.snackbar("Gagal", "Error from Account TAB : ${tradingAccountController.responseMessage.value}", backgroundColor: Colors.red, colorText: Colors.white);
            });
          },
          color: GlobalVariablesType.mainColor,
          backgroundColor: Colors.black,
          child: ListView(
            children: [
              const CardMenuAccount(),
              // ignore: prefer_is_empty
              Obx(() {
                if(tradingAccountController.listTradingAccount.value == null){
                  return SizedBox(
                    width: size.width,
                    height: size.height / 2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.candlestick_chart_outlined, size: 35, color: GlobalVariablesType.mainColor),
                        SizedBox(height: 5),
                        Text("Anda belum memilik akun trading", style: TextStyle(color: GlobalVariablesType.mainColor), textAlign: TextAlign.center)
                      ],
                    ),
                  );
                }else{
                  // ignore: prefer_is_empty
                  if(tradingAccountController.listTradingAccount.value!.response.length < 1){
                    return SizedBox(
                      width: size.width,
                      height: size.height / 2,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.candlestick_chart_outlined, size: 35, color: Colors.black54),
                          SizedBox(height: 5),
                          Text("Anda belum memilik akun trading", style: TextStyle(color: Colors.black54), textAlign: TextAlign.center)
                        ],
                      ),
                    );
                  }else{
                    return Obx(
                      () => accountsController.isLoading.value ? const CircularProgressIndicator() : Column(
                        children: List.generate(tradingAccountController.listTradingAccount.value!.response.length, (i){
                          if(tradingAccountController.listTradingAccount.value!.response[i].type == "real"){
                            return CardAccountReal(
                              showTransferMenu: true,
                              tradingIDNumber: tradingAccountController.listTradingAccount.value?.response[i].login,
                              accountType: tradingAccountController.listTradingAccount.value?.response[i].namaTipeAkun,
                              rate: tradingAccountController.listTradingAccount.value?.response[i].rate,
                              currencyType: tradingAccountController.listTradingAccount.value?.response[i].currency,
                              balance: tradingAccountController.listTradingAccount.value?.response[i].balance.toString(),
                              tradingID: tradingAccountController.listTradingAccount.value?.response[i].id,
                              depositAmount: tradingAccountController.listTradingAccount.value?.response[i].totalDeposit,
                              margin: tradingAccountController.listTradingAccount.value?.response[i].marginFree.toString(),
                              withdrawalAmount: tradingAccountController.listTradingAccount.value?.response[i].totalWithdrawal,
                            );
                          }else if(tradingAccountController.listTradingAccount.value!.response[i].type == "demo"){
                            return CardAccountDemo(
                              balance: tradingAccountController.listTradingAccount.value?.response[i].balance.toString(),
                              depositAmount: tradingAccountController.listTradingAccount.value?.response[i].totalDeposit,
                              margin: tradingAccountController.listTradingAccount.value?.response[i].marginFreePercent.toString(),
                              tradingID: tradingAccountController.listTradingAccount.value?.response[i].login,
                            );
                          }else{
                            return const SizedBox();
                          }
                        }),
                      ),
                    );
                  }
                }
              })
            ],
          )
        ),
      ),
    );
  }
}