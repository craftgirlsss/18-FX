import 'package:delapanbelasfx/src/components/action_sheet.dart';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/cupertino_form_row.dart';
import 'package:delapanbelasfx/src/components/cupertino_form_row_currency.dart';
import 'package:delapanbelasfx/src/components/cupertino_list_section_insert_group.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:delapanbelasfx/src/helpers/format_currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalAccount extends StatefulWidget {
  final String? akunTradingPenerima;
  final String? akunTradingID;
  final String? jumlahBalance;
  final String? currencyType;
  final String? rate;
  const WithdrawalAccount({super.key, this.akunTradingPenerima, this.jumlahBalance, this.currencyType, this.rate, this.akunTradingID});

  @override
  State<WithdrawalAccount> createState() => _WithdrawalAccountState();
}

class _WithdrawalAccountState extends State<WithdrawalAccount> {

  final _formKey = GlobalKey<FormState>();
  TradingAccountController tradingAccountController = Get.find();
  RxString currencyType = "".obs;
  RxInt balance = 0.obs;
  RxBool isLoading = false.obs;
  RxInt balanceWillReceived = 0.obs;
  RxString selectedBankID = "".obs;
  TextEditingController amount = TextEditingController();
  TextEditingController akunTradingPenerima = TextEditingController();
  TextEditingController bankOption = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController jumlahBalance = TextEditingController();
  TextEditingController nomorRekeningBank = TextEditingController();
  TextEditingController rate = TextEditingController();

  void initBankUser(){
    selectedBankID(tradingAccountController.bankUserModels.value?.response[0].id);
    bankOption.text = tradingAccountController.bankUserModels.value?.response[0].name ?? "Unknown Bank Name";
    nomorRekeningBank.text = tradingAccountController.bankUserModels.value?.response[0].account ?? "Unknown Bank Name";
    bankName.text = tradingAccountController.bankUserModels.value?.response[0].userName ?? "Unknown Bank Name";
    jumlahBalance.text = widget.jumlahBalance ?? '0';
    rate.text = widget.rate ?? "Unknown Rate Trading Account";
    jumlahBalance.text = widget.jumlahBalance ?? "0";
  }

  @override
  void initState() {
    super.initState();
    akunTradingPenerima.text = widget.akunTradingPenerima ?? "0";
    Future.delayed(Duration.zero, (){
      tradingAccountController.getListBankUser().then((resultBankUser){
        if(resultBankUser){
          initBankUser();
        }else{
          alertError(title: "Gagal", message: "Gagal mendapatkan informasi bank user", onTap: (){Navigator.pop(context);});
        }
      });
    });
  }

  @override
  void dispose() {
    amount.dispose();
    akunTradingPenerima.dispose();
    bankOption.dispose();
    jumlahBalance.dispose();
    bankName.dispose();
    nomorRekeningBank.dispose();
    rate.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: AppBar(
          title: Text("Withdrawal Akun #ID${widget.akunTradingPenerima}", style: const TextStyle(color: Colors.white, fontSize: 16)),
          iconTheme: const CupertinoIconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () => isLoading.value ? const SizedBox() : CustomCupertinoListSectionInsertGroup(
                    // footer: "Transaksi anda akan diterima oleh admin perusahaan, mohon isikan semua data dengan benar dan dapat dipertanggung jawabkan.",
                    header: "Bank Penerima",
                    footer: "Isikan semua field dengan informasi yang benar dan dapat dipertanggung jawabkan kebenaranya.\nUang yang akan anda terima sebesar ${formatCurrencyId.format(balanceWillReceived.value)}",
                    children: [
                      CustomCupertinoFormRow(controller: bankOption, readOnly: true, prefix: "Pilih Bank", placeholder: "Select here", onPressed: (){
                        showActionSheet(context, message: "Pilih rekening bank yang anda miliki", title: "Pilih Rekening", list: List.generate(tradingAccountController.bankUserModels.value?.response.length ?? 0, (i){
                          return CupertinoActionSheetAction(
                            onPressed: (){
                              selectedBankID(tradingAccountController.bankUserModels.value?.response[i].id);
                              bankOption.text = tradingAccountController.bankUserModels.value?.response[i].name ?? "Unknown Bank Name";
                              nomorRekeningBank.text = tradingAccountController.bankUserModels.value?.response[i].account ?? "Unknown Bank Account Number";
                              bankName.text = tradingAccountController.bankUserModels.value?.response[i].userName ?? "Unknown Bank Account Username";
                              Navigator.pop(context);
                            },
                            child: Text(tradingAccountController.bankUserModels.value?.response[i].name ?? "-"),
                          );
                        }));
                      }),
                      CustomCupertinoFormRow(controller: bankName, readOnly: true, prefix: "Nama Pemilik", placeholder: "Select Bank Option first"),
                      CustomCupertinoFormRow(controller: nomorRekeningBank, readOnly: true, prefix: "Nomor Rekening", placeholder: "Select Bank Option first"),
                      CustomCupertinoFormRow(controller: akunTradingPenerima, readOnly: true, prefix: "ID Akun Trading", placeholder: "Select Real Account"),
                      CustomCupertinoFormRow(controller: rate, readOnly: true, prefix: "Rate Akun Trading", placeholder: "Rate Info"),
                      CustomCupertinoFormRow(controller: jumlahBalance, readOnly: true, prefix: "Jumlah Balance Akun", placeholder: "Your total Balance", prefixWidget: const Text("USD", style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 15))),
                      CustomCupertinoFormRowCurrency(controller: amount, readOnly: false, prefix: "Jumlah Withdrawal", textInputType: TextInputType.number, currencyType: "USD", textInputAction: TextInputAction.done, onFieldSubmitted: (value){
                        if(value != "0" || value != "" || value.isNotEmpty){
                          tradingAccountController.moneyConversion(amount: value, tradingID: widget.akunTradingID).then((result){
                            if(result){
                              balanceWillReceived(tradingAccountController.moneyConversionModels.value?.response.amountReceived);
                            }
                          });
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Obx(
              () => CupertinoButton(
                onPressed: tradingAccountController.isLoading.value ? (){} : () async {
                  if(_formKey.currentState!.validate()){
                    tradingAccountController.withdrawal(
                      amount: amount.text,
                      tradingID: widget.akunTradingID,
                      userBankID: selectedBankID.value, 
                    ).then((result){
                      if(result){
                        alertDialogCustomSuccess(title: "Berhasil", message: tradingAccountController.responseMessage.value, onTap: (){Navigator.of(context)..pop()..pop();});
                      }else{
                        alertError(title: "Gagal", message: tradingAccountController.responseMessage.value, onTap: (){Navigator.pop(context);});
                      }
                    });
                  }else{
                    alertError(title: "Gagal", message: "Mohon isikan semua fields", onTap: (){Navigator.pop(context);});
                  }
                },
                color: GlobalVariablesType.mainColor,
                child: tradingAccountController.isLoading.value ? const CupertinoActivityIndicator() : const Text("Withdraw", style: TextStyle(color: CupertinoColors.black))
              ),
            ),
          ),
        ),
      ),
    );
  }
}