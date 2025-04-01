import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/format_currencies.dart';
import 'package:delapanbelasfx/src/views/dashboard/setting/confirmation_page_for_creating_new_real_accounts.dart';

Widget realAccount(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          border: Border.all(color: CupertinoColors.systemIndigo),
          borderRadius: BorderRadius.circular(13)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: kDefaultTextStyleCustom(),
                  child: Text(
                    "IBFTrader MT4 Real",
                    style: kDefaultTextStyleCustom(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/mt4.png",
                width: 40,
              )
            ],
          ),
          descriptions(
              descriptions: "Floating spread, markup",
              title: "Spread from",
              value: "0.6 pips"),
          descriptions(
              descriptions: "Currencies, indices, metals, energies",
              title: "Instruments",
              value: "32"),
          descriptions(
              descriptions: "Favorable: \$100",
              title: "Minimum deposit",
              value: "\$100"),
          descriptions(title: "Maximum leverage", value: "1:500"),
          descriptions(title: "Margin call", value: "0.25"),
          descriptions(title: "Stop out level", value: "0.15"),
          const SizedBox(height: 20),
          kDefaultButtonLogin(
            onPressed: (){},
            title: "CONFIGURE"
          ),
        ],
      ),
    );
  }

  Container demoAccount(context,
      {int? amountOfInstruments,
      double? spread,
      String? platformMT,
      int? amountOfMoney,
      String? filename,
      String typeAccount = "Demo",
      String? leverage,
      double? marginCall,
      double? stopOutLevel}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.8,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color:CupertinoColors.darkBackgroundGray,
          border: Border.all(width: 0.3, color: Colors.white24),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: kDefaultTextStyleCustom(),
                  child: Text(
                    "GIFX $platformMT",
                    style: kDefaultTextStyleCustom(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/$filename",
                width: 40,
              )
            ],
          ),
          descriptions(
              descriptions: "Floating spread, markup",
              title: "Spread from",
              value:
                  "${spread != null ? spread.toString() : 0.toString()} pips"),
          descriptions(
              descriptions: "Currencies, indices, metals, energies",
              title: "Instruments",
              value:
                  "${amountOfInstruments != null ? amountOfInstruments.toString() : 0.toString()} items"),
          descriptions(
              title: "Amount of Money",
              value:
                  "${amountOfMoney != null ? formatCurrencyUs.format(amountOfMoney) : 0}"),
          descriptions(title: "Leverage", value: "${leverage ?? 0}"),
          descriptions(title: "Margin call", value: "${marginCall ?? 0}"),
          descriptions(title: "Stop out level", value: "${stopOutLevel ?? 0}"),
          const SizedBox(height: 20),
          kDefaultButtonLogin(
            onPressed: typeAccount == "Demo" ? (){} : (){},
            title: "CONFIGURE"
          ),
        ],
      ),
    );
  }

  Container realAccounts(context,
      {int? amountOfInstruments,
      double? spread,
      String? platformMT,
      int? minimumDeposit,
      String? filename,
      String typeAccount = "Demo",
      String? leverage,
      double? marginCall,
      double? stopOutLevel}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.8,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color:CupertinoColors.darkBackgroundGray,
          border: Border.all(width: 0.3, color: Colors.white24),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: kDefaultTextStyleCustom(),
                  child: Text(
                    "GIFX $platformMT",
                    style: kDefaultTextStyleCustom(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/$filename",
                width: 40,
              )
            ],
          ),
          descriptions(
              descriptions: "Floating spread, markup",
              title: "Spread from",
              value:
                  "${spread != null ? spread.toString() : 0.toString()} pips"),
          descriptions(
              descriptions: "Currencies, indices, metals, energies",
              title: "Instruments",
              value:
                  "${amountOfInstruments != null ? amountOfInstruments.toString() : 0.toString()} items"),
          descriptions(
              title: "Minimum Deposit",
              value:
                  "${minimumDeposit != null ? formatCurrencyUs.format(minimumDeposit) : 0}"),
          descriptions(title: "Maximum Leverage", value: "${leverage ?? 0}"),
          descriptions(title: "Margin call", value: "${marginCall ?? 0}"),
          descriptions(title: "Stop out level", value: "${stopOutLevel ?? 0}"),
          const SizedBox(height: 20),
          kDefaultButtonLogin(
            onPressed: (){
              Get.to(() => ConfirmationPageForCreatingNewRealAccounts(
                titleAppBar: "GIFX $platformMT",
              ));
            },
            title: "CONFIGURE"
          ),
        ],
      ),
    );
  }

  Widget descriptions({String? title, String? value, String? descriptions}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultTextStyle(
              style: kDefaultTextStyleCustom(
                fontSize: 14
              ),
              child: Text(
                title!,
              ),
            ),
            DefaultTextStyle(
              style: kDefaultTextStyleCustom(),
              child: Text(
                value!,
              ),
            ),
          ],
        ),
        descriptions != null
            ? Row(
                children: [
                  DefaultTextStyle(
                      style: kDefaultTextStyleCustom(
                        color: Colors.white54,
                        fontWeight: FontWeight.normal
                      ),
                      textAlign: TextAlign.left,
                      child: Text(descriptions)),
                ],
              )
            : const SizedBox(
                height: 0,
                width: 0,
              )
      ],
    );
  }