import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import '../views/dashboard/setting/payment_provider_page.dart';
import 'icon_circle_with_image.dart';

Widget realAccountCard(context, {String? accountID, String? money}){
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(25),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(width: 0.3, color: Colors.white30),
      borderRadius: BorderRadius.circular(25),
      color: CupertinoColors.darkBackgroundGray,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/ic_launcher.png', width: 20),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GlobalVariablesType.mainColor
              ),
              child: Center(child: Text("Real", style: kDefaultTextStyleCustom(fontSize: 7, color: Colors.black))),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(accountID ?? "null", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal),),
            Text("\$$money", style: kDefaultTextStyleCustom(fontSize: 16),)
          ],
        ),
        const SizedBox(height: 15),
        Text("Deposit Methods", style: kDefaultTextStyleCustom(fontSize: 14)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconCircleWithImage(
              assetImageURL: 'assets/images/qris.png',
              onTap: (){},
              title: "QRIS"
            ),
            iconCircleWithImage(
              assetImageURL: 'assets/images/bca.png',
              onTap: (){},
              title: "Bank BCA"
            ),
            iconCircleWithImage(
              onTap: (){},
              title: "View more",
              withImage: false,
              icons: Icons.wallet
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  Get.to(const PaymentProviderPage());
                },
                child: Row(
                  children: [
                    const Icon(Icons.wallet, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("DEPOSIT", style: kDefaultTextStyleCustom(fontSize: 14))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart_rounded, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("TRADE", style: kDefaultTextStyleCustom(fontSize: 14)),
                    const SizedBox(width: 20),
                    const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    )
  );
}


Widget demoAccountCard(context, {String? accountID, String? money}){
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(25),
    width: MediaQuery.of(context).size.width / 1.2,
    decoration: BoxDecoration(
      border: Border.all(width: 0.3, color: Colors.white30),
      borderRadius: BorderRadius.circular(25),
      color: CupertinoColors.darkBackgroundGray,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/ic_launcher.png', width: 20),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GlobalVariablesType.mainColor
              ),
              child: Center(child: Text("Real", style: kDefaultTextStyleCustom(fontSize: 7, color: Colors.black))),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(accountID ?? "null", style: kDefaultTextStyleCustom(fontWeight: FontWeight.normal),),
            Text("\$$money", style: kDefaultTextStyleCustom(fontSize: 16),)
          ],
        ),
        const SizedBox(height: 15),
        Text("Deposit Methods", style: kDefaultTextStyleCustom(fontSize: 14)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconCircleWithImage(
              assetImageURL: 'assets/images/qris.png',
              onTap: (){},
              title: "QRIS"
            ),
            iconCircleWithImage(
              assetImageURL: 'assets/images/bca.png',
              onTap: (){},
              title: "Bank BCA"
            ),
            iconCircleWithImage(
              onTap: (){},
              title: "View more",
              withImage: false,
              icons: Icons.wallet
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    const Icon(Icons.wallet, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("DEPOSIT", style: kDefaultTextStyleCustom(fontSize: 14))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart_rounded, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("TRADE", style: kDefaultTextStyleCustom(fontSize: 14)),
                    const SizedBox(width: 20),
                    const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    )
  );
}