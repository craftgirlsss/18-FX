import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/card_portofolio.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/dashboard/markets/market_details.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  AccountsController accountsController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: GlobalVariablesType.backgroundColor,
          appBar: kDefaultAppBarTitle(
            title: "Quotes",
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CardPortofolio(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Assets", style: kDefaultTextStyleTitleAppBar(fontSize: 17),),
                      CupertinoButton(onPressed: (){}, child: const Text("See All")),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => Get.to(() => const MarketDetails(title: "EURUSD")),
                      title: Text("EURO / USD", style: kDefaultTextStyleTitleAppBar(fontSize: 15)),
                      subtitle: Text("EURUSD", style: kDefaultTextStyleTitleAppBar(fontSize: 13, fontWeight: FontWeight.normal)),
                      leading: Image.asset('assets/icons/flags/eurusd.png', width: 55),
                      trailing: Column(
                        children: [
                          Text("\$119.83", style: kDefaultTextStyleTitleAppBar(fontSize: 15)),
                          Text("+3.2%", style: kDefaultTextStyleButtonText(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
