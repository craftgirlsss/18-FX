import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/helpers/format_currencies.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/deposit_account.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/detail_account_page.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/documents_account.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/internal_transfer.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/withdrawal_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CardAccountReal extends StatefulWidget {
  final String? tradingID;
  final String? tradingIDNumber;
  final String? rate;
  final String? margin;
  final String? balance;
  final String? depositAmount;
  final String? withdrawalAmount;
  final String? currencyType;
  final String? accountType;
  final bool? showTransferMenu;
  const CardAccountReal({super.key, this.tradingID, this.margin, this.balance, this.depositAmount, this.withdrawalAmount, this.currencyType, this.rate, this.accountType, this.tradingIDNumber, this.showTransferMenu});

  @override
  State<CardAccountReal> createState() => _CardAccountRealState();
}

class _CardAccountRealState extends State<CardAccountReal> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(8.0),
      onPressed: (){
        Get.to(() => DetailAccountPage(loginID: widget.tradingIDNumber, accountCurrency: widget.currencyType));
      },
      child: Banner(
        message: widget.accountType ?? "New",
        location: BannerLocation.topEnd,
        color: Colors.red,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
            color: GlobalVariablesType.backgroundColor,
            // boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child: Text("REAL - ${widget.tradingIDNumber ?? '0'}", style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child: Text(widget.currencyType ?? "AN", style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold))),
                  ),
                  widget.showTransferMenu == true ? CupertinoButton(
                    onPressed: (){
                      Get.to(() => InternalTransfer(
                        accountCurrency: widget.currencyType,
                        accountNumber: widget.tradingIDNumber,
                        balance: widget.balance,
                        accountTypeName: widget.accountType,
                      ));
                    },
                    child: const Row(
                      children: [
                        Icon(MingCute.transfer_line, color: Colors.white70, size: 15),
                        SizedBox(width: 3),
                        Text("Transfer", style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    )
                  ).paddingZero.marginZero : const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Free Margin", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white70)),
                      Text("79% Equity", style: TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          annotations: const [
                            GaugeAnnotation(
                              angle: 90,
                              // widget: Text(progressValue.toStringAsFixed(0), style: const TextStyle(fontSize: 11),
                              widget: Text("79%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
                              )
                            )
                          ],
                          pointers: const [
                            RangePointer(
                              value: 79,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color:Color.fromARGB(78, 25, 184, 195),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                        )
                      ]
                    )
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Balance", style: TextStyle(color: Colors.white60, fontSize: 15)),
                        Text("\$ ${widget.balance ?? "0.00"}" , style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Total Deposit : ${widget.depositAmount != null ? formatCurrencyUs.format(int.tryParse(widget.depositAmount!)) : '\$ 0'}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        Text("Total Withdrawal : ${widget.withdrawalAmount != null ? formatCurrencyUs.format(int.tryParse(widget.withdrawalAmount!)) : '\$ 0'}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomCupertinoButton.tint(
                      title: "Deposit",
                      iconData: CupertinoIcons.tray_arrow_down_fill,
                      onPressed: (){
                        Get.to(() => DepositAccount(akunTradingPengirim: widget.tradingIDNumber, akunTradingID: widget.tradingID, jumlahBalance: widget.balance, accountTradingCurrencyType: widget.currencyType, rate: widget.rate));
                      }
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomCupertinoButton.tint(
                      title: "Withdrawal",
                      iconData: CupertinoIcons.tray_arrow_up_fill,
                      onPressed: (){
                        Get.to(() => WithdrawalAccount(akunTradingPenerima: widget.tradingIDNumber, akunTradingID: widget.tradingID, jumlahBalance: widget.balance, currencyType: widget.currencyType, rate: widget.rate));
                      }
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomCupertinoButton.tint(
                      title: "Dokumen",
                      iconData: CupertinoIcons.doc_person_fill,
                      onPressed: (){
                        Get.to(() => const DocumentsAccount());
                      }
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}