import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class ListViewMarketRunning extends StatefulWidget {
  const ListViewMarketRunning({super.key});

  @override
  State<ListViewMarketRunning> createState() => _ListViewMarketRunningState();
}

class _ListViewMarketRunningState extends State<ListViewMarketRunning> {
  AccountsController accountsController = Get.find();
  late final stream = FirebaseDatabase.instance.ref('data/').onValue;
  int getNumberAfterDecimal(double number) {
    String numberString = number.toString();
    List<String> parts = numberString.split('.');
    if (parts.length < 2 || parts[1].isEmpty) {
      return 0;
    }
    int afterDecimal = int.parse(parts[1]);
    return afterDecimal;
  }

  int getNumberBeforeDecimal(double number) {
    double beforeDecimal = number.truncateToDouble();    
    return beforeDecimal.toInt();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: appBarHomePage(
        context, 
        onPressedNotification: () {
          Get.snackbar("Gagal", "Fitur masih dalam pengembangan", backgroundColor: Colors.white, colorText: Colors.black);
          // Get.to(() => const NotificationPage());
        }, 
        onPressedProfile: (){}, 
        availableNotofication: true,
        name: accountsController.accountsModels.value?.response?.personalDetail.name ?? "Unknonwn",
        urlPhoto: accountsController.accountsModels.value?.response?.personalDetail.urlPhoto ?? "Unknonwn",
      ),
      body: StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CupertinoActivityIndicator(color: Colors.white54);
          } else if(snapshot.hasError){
            return Text("Tidak ada data", style: kDefaultTextStyleCustom());
          } else if(snapshot.hasData){
            print("ini hasil realtime database firebase ${snapshot.data}");
            return ListView.separated(
              itemBuilder: (context, index) {
                // ask value
                String? askValueBeforeDecimal = getNumberBeforeDecimal(listMarket[index].askValue!).toString();
                String? askValueAfterDecimal = getNumberAfterDecimal(listMarket[index].askValue!).toString();
                // bid value
                String? bidValueBeforeDecimal = getNumberBeforeDecimal(listMarket[index].bidValue!).toString();
                String? bidValueAfterDecimal = getNumberAfterDecimal(listMarket[index].bidValue!).toString();
                return Container(
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0.1)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // flags market
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(listMarket[index].urlImage!, width: 55),
                          const SizedBox(height: 5),
                          Text(listMarket[index].marketName!, style: kDefaultTextStyleButtonText(color: Colors.white60),)
                        ],
                      ),
            
                      // icon up down
                      const Icon(Icons.arrow_drop_down, color: Colors.red),
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '$bidValueBeforeDecimal.',
                                style: kDefaultTextStyleCustom(fontSize: 17, fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(text: bidValueAfterDecimal, style: kDefaultTextStyleCustom(fontSize: 30, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Text("Spread: 4", style: kDefaultTextStyleButtonText(color: Colors.white60)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_drop_up, color: Colors.green),
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '$askValueBeforeDecimal.',
                                style: kDefaultTextStyleCustom(fontSize: 17, fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(text: askValueAfterDecimal, style: kDefaultTextStyleCustom(fontSize: 30, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("H: ${listMarket[index].high}", style: kDefaultTextStyleButtonText(color: Colors.white60),),
                                const SizedBox(width: 5),
                                Text("L: ${listMarket[index].low}",style: kDefaultTextStyleButtonText(color: Colors.white60),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, 
              separatorBuilder: (context, index) => const SizedBox(height: 0.3), 
              itemCount: listMarket.length);
          } else {
            return const Text("Tidak ada data");
          }
        }
      )
    );
  }
  List<MarketPrice> listMarket = [
    MarketPrice(askValue: 10.302, bidValue: 10.483, marketName: "EURUSD", urlImage: "assets/icons/flags/eurusd.png", high: 10.502, low: 10.467),
    MarketPrice(askValue: 8.758, bidValue: 8.723, marketName: "AUDNZD", urlImage: "assets/icons/flags/audnzd.png", high: 8.753, low: 8.720),
    MarketPrice(askValue: 20.103, bidValue: 20.083, marketName: "GBPJPY", urlImage: "assets/icons/flags/gbpjpy.png", high: 10.502, low: 10.467),
    MarketPrice(askValue: 501.32, bidValue: 500.22, marketName: "USDCAD", urlImage: "assets/icons/flags/usdcad.png", high: 10.502, low: 10.467),
    MarketPrice(askValue: 11.302, bidValue: 11.205, marketName: "CHFJPY", urlImage: "assets/icons/flags/chfjpy.png", high: 10.502, low: 10.467),
  ];
}

class MarketPrice{
  String? urlImage;
  String? marketName;
  double? bidValue;
  double? askValue;
  double? high;
  double? low;
  MarketPrice({this.urlImage,this.marketName,this.bidValue,this.askValue, this.high, this.low});
}