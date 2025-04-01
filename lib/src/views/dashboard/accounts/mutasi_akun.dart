import 'package:delapanbelasfx/src/components/cards_button.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MutasiAkun extends StatefulWidget {
  final String? akunTradingPengirim;
  const MutasiAkun({super.key, this.akunTradingPengirim});

  @override
  State<MutasiAkun> createState() => _MutasiAkunState();
}

class _MutasiAkunState extends State<MutasiAkun> {
  TradingAccountController tradingAccountController = Get.find();
  DateTime now = DateTime.now();

  List<Map<String, dynamic>> listTransactions = [
    {
      "id"     : "420390255",
      "type"   : "Deposit",
      "from"   : "BCA",
      "amount" : "100.00",
      "status" : 1,
      "date"   : "2025-03-07"
    },
    {
      "id"     : "423192255",
      "type"   : "Withdrawal",
      "from"   : "BNI",
      "amount" : "53.30",
      "status" : 1,
      "date"   : "2025-03-10"
    },
    {
      "id"     : "420390252",
      "type"   : "Withdrawal",
      "from"   : "BNI",
      "amount" : "20.33",
      "status" : -1,
      "date"   : "2025-03-09"
    },
    {
      "id"     : "420390262",
      "type"   : "Deposit",
      "from"   : "BCA",
      "amount" : "100",
      "status" : 2,
      "date"   : "2025-03-02"
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      tradingAccountController.mutasiAkun().then((result){
        if(kDebugMode) print(result);
        if(!result) Get.snackbar("Gagal", tradingAccountController.responseMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text("Riwayat Deposit & Withdrawal"),
            ),
            body: RefreshIndicator(
              color: GlobalVariablesType.mainColor,
              backgroundColor: Colors.black,
              onRefresh: () async {
                tradingAccountController.mutasiAkun().then((result){
                  if(kDebugMode) print(result);
                  if(!result) Get.snackbar("Gagal", tradingAccountController.responseMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
                });
              },
              child: ListView.builder(
                itemCount: listTransactions.length,
                itemBuilder: (context, i) => CardsButton.cardMutasi(
                  type: listTransactions[i]['type'],
                  amount: listTransactions[i]['amount'],
                  date: listTransactions[i]['date'],
                  from: listTransactions[i]['from'],
                  status: listTransactions[i]['status'],
                  transactionID: listTransactions[i]['id'],
                ),
              ),
              /*
              child: Obx(
                () => tradingAccountController.dpwdModels.value?.response == null 
                ? ListView(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height / 1.3,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Iconsax.empty_wallet_outline, size: 35, color: Colors.white),
                          SizedBox(height: 5),
                          Text("Belum ada Riwayat", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                )
                : ListView(
                  padding: const EdgeInsets.all(15),
                  children: List.generate(tradingAccountController.dpwdModels.value?.response.length ?? 0, (i){
                    if(tradingAccountController.dpwdModels.value!.response.isEmpty){
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Iconsax.empty_wallet_outline, size: 35, color: Colors.white),
                            SizedBox(height: 5),
                            Text("Belum ada Riwayat", style: TextStyle(color: Colors.white))
                          ],
                        ),
                      );
                    }
                    return CardsButton.cardMutasi(
                      type: listTransactions[i]['type'],
                      amount: listTransactions[i]['amount'],
                      date: listTransactions[i]['date'],
                      from: listTransactions[i]['from'],
                      status: listTransactions[i]['status'],
                      transactionID: listTransactions[i]['id'],
                    );
                  }),
                ),
              ),
              */
            )
          ),
          Obx(() => tradingAccountController.isLoading.value ? floatingLoading() : const SizedBox())
        ],
      ),
    );
  }
}