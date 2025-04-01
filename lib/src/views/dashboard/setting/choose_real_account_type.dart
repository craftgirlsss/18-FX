import 'package:flutter/material.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/demo_account_card.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';

class ChooseRealAccountTypePage extends StatefulWidget {
  const ChooseRealAccountTypePage({super.key});

  @override
  State<ChooseRealAccountTypePage> createState() => _ChooseRealAccountTypePageState();
}

class _ChooseRealAccountTypePageState extends State<ChooseRealAccountTypePage> {
  PageController pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    pageController.addListener((){
      setState(() {
        currentPage = pageController.page!;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, title: Text("Choose your account", style: kDefaultTextStyleCustom(fontSize: 15))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: PageView(
          controller: pageController,
          pageSnapping: true,
          children: [
            realAccounts(context,
              amountOfInstruments: 32,
              platformMT: "MetaTrader 4",
              filename: "mt4.png",
              leverage: "1:500",
              typeAccount: "Real",
              minimumDeposit: 50,
              spread: 0.6,
              marginCall: 0.25,
              stopOutLevel: 0.15),
            realAccounts(context,
              amountOfInstruments: 230,
              platformMT: "MetaTrader 5",
              filename: "mt5.png",
              typeAccount: "Real",
              leverage: "1:500",
              minimumDeposit: 50,
              spread: 0.6,
              marginCall: 0.25,
              stopOutLevel: 0.15),
          ]
        ),
      )
    );
  }
}