import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/helpers/format_currencies.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/deposit_account.dart';
import 'package:delapanbelasfx/src/views/dashboard/accounts/detail_account_page.dart';
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
            border: Border.all(color: Colors.black12),
            color: GlobalVariablesType.backgroundColor,
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child: Text("REAL - ${widget.tradingIDNumber ?? '0'}", style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child: Text(widget.currencyType ?? "AN", style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
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
                        Icon(MingCute.transfer_line, color: Colors.black38, size: 15),
                        SizedBox(width: 3),
                        Text("Transfer", style: TextStyle(color: Colors.black45, fontSize: 13)),
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
                      Text("Free Margin", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54)),
                      Text("100% Equity", style: TextStyle(color: Colors.black45, fontSize: 12)),
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
                              widget: Text("100%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black45),
                              )
                            )
                          ],
                          pointers: const [
                            RangePointer(
                              value: 100,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color:Colors.black12,
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
                        const Text("Balance", style: TextStyle(color: Colors.black45, fontSize: 15)),
                        Text("\$ ${widget.balance ?? "0.00"}" , style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black45)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Total Deposit : ${widget.depositAmount != null ? formatCurrencyId.format(int.tryParse(widget.depositAmount!)) : 'IDR 0'}", style: const TextStyle(color: Colors.black38, fontSize: 12)),
                        Text("Total Withdrawal : ${widget.withdrawalAmount != null ? formatCurrencyId.format(int.tryParse(widget.withdrawalAmount!)) : '\$ 0'}", style: const TextStyle(color: Colors.black38, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: CustomCupertinoButton.tintTransparent(
                      title: "Deposit",
                      iconData: CupertinoIcons.tray_arrow_down_fill,
                      onPressed: (){
                        Get.to(() => DepositAccount(akunTradingPengirim: widget.tradingIDNumber, akunTradingID: widget.tradingID, jumlahBalance: widget.balance, accountTradingCurrencyType: widget.currencyType, rate: widget.rate));
                      }
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomCupertinoButton.tintTransparent(
                      title: "Withdrawal",
                      iconData: CupertinoIcons.tray_arrow_up_fill,
                      onPressed: (){
                        Get.to(() => WithdrawalAccount(akunTradingPenerima: widget.tradingIDNumber, akunTradingID: widget.tradingID, jumlahBalance: widget.balance, currencyType: widget.currencyType, rate: widget.rate));
                      }
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomCupertinoButton.tintTransparent(
                      title: "Dokumen",
                      iconData: CupertinoIcons.doc_person_fill,
                      onPressed: (){
                        alertError(
                          message: "Fitur masih dalam proses pengembangan",
                          onTap: (){
                            Get.back();
                          },
                          title: "Gagal"
                        );
                        // Get.to(() => const DocumentsAccount());
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