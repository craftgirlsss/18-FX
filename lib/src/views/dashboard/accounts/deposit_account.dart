import 'package:delapanbelasfx/src/components/action_sheet.dart';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/cupertino_form_row.dart';
import 'package:delapanbelasfx/src/components/cupertino_form_row_currency.dart';
import 'package:delapanbelasfx/src/components/cupertino_list_section_insert_group.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/photo_viewer.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DepositAccount extends StatefulWidget {
  final String? akunTradingPengirim;
  final String? jumlahBalance;
  final String? akunTradingID;
  final String? accountTradingCurrencyType;
  final String? rate;
  const DepositAccount({super.key, this.akunTradingPengirim, this.jumlahBalance, this.accountTradingCurrencyType, this.rate, this.akunTradingID});

  @override
  State<DepositAccount> createState() => _DepositAccountState();
}

class _DepositAccountState extends State<DepositAccount> {
  TradingAccountController tradingAccountController = Get.find();

  final _formKey = GlobalKey<FormState>();
  RxString currencyType = "".obs;
  RxInt balance = 0.obs;
  RxInt balanceWillReceived = 0.obs;
  RxBool isLoading = false.obs;
  RxString bankAdminID = "".obs;
  RxString selectedUserBankID = "".obs;

  // Bank Pengirim
  TextEditingController jumlahDepositPengirim = TextEditingController();
  TextEditingController akunTradingPengirim = TextEditingController();
  TextEditingController pilihanBankPengirim = TextEditingController();
  TextEditingController namaBankPengirim = TextEditingController();
  TextEditingController nomorRekeningPengirim = TextEditingController();
  TextEditingController jumlahBalance = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController transactionProof = TextEditingController();

  // Bank Penerima
  TextEditingController pilihanBankPenerima = TextEditingController();
  TextEditingController namaBankPenerima = TextEditingController();
  TextEditingController nomorRekeningPenerima = TextEditingController();

  void initBankUser(){
    selectedUserBankID(tradingAccountController.bankUserModels.value?.response[0].id);
    pilihanBankPengirim.text = tradingAccountController.bankUserModels.value?.response[0].name ?? "Unknown Bank Name";
    nomorRekeningPengirim.text = tradingAccountController.bankUserModels.value?.response[0].account  ?? "Unknown Bank Account";
    namaBankPengirim.text = tradingAccountController.bankUserModels.value?.response[0].userName ?? "Unknown Bank Holder";
    rate.text = widget.rate ?? "Unknown Rate Trading Account";
    jumlahBalance.text = widget.jumlahBalance ?? "0";
  }

  void initBankAdmin(){
    bankAdminID(tradingAccountController.bankAdminModels.value!.response[0].id);
    pilihanBankPenerima.text = tradingAccountController.bankAdminModels.value!.response[0].bankName ?? "Unknonwn Bank Name";
    nomorRekeningPenerima.text = tradingAccountController.bankAdminModels.value?.response[0].bankAccount ?? "0";
    namaBankPenerima.text = tradingAccountController.bankAdminModels.value?.response[0].bankHolder ?? "Unknown Bank Holder";
  }

  @override
  void initState() {
    super.initState();
    akunTradingPengirim.text = widget.akunTradingPengirim ?? "0";
    Future.delayed(Duration.zero, (){
      tradingAccountController.getListBankAdmin(currency: widget.accountTradingCurrencyType).then((result){
        if(result){
          initBankAdmin();
          tradingAccountController.getListBankUser().then((resultBankUser){
            if(resultBankUser){
              initBankUser();
            }else{
              alertError(title: "Gagal", message: "Gagal mendapatkan informasi bank user", onTap: (){Navigator.pop(context);});
            }
          });
        }else{
          alertError(title: "Gagal", message: "Gagal mendapatkan informasi bank admin", onTap: (){Navigator.pop(context);});
        }
      });
    });
  }

  @override
  void dispose() {
    jumlahDepositPengirim.dispose();
    akunTradingPengirim.dispose();
    pilihanBankPengirim.dispose();
    namaBankPengirim.dispose();
    nomorRekeningPengirim.dispose();
    pilihanBankPenerima.dispose();
    namaBankPenerima.dispose();
    nomorRekeningPenerima.dispose();
    rate.dispose();
    transactionProof.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Deposit Akun #ID${widget.akunTradingPengirim}", style: TextStyle(color: GlobalVariablesType.mainColor, fontSize: 16)),
          iconTheme: CupertinoIconThemeData(color: GlobalVariablesType.mainColor),
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
                    footer: "Pilih bank penerima untuk anda deposit ke rekening ${widget.accountTradingCurrencyType} PT. Delapan Belas Berjangka.",
                    children: [
                      CustomCupertinoFormRow(controller: pilihanBankPenerima, readOnly: true, prefix: "Pilih Bank", placeholder: "Select here", onPressed: (){
                        showActionSheet(context, message: "Pilih rekening bank ${widget.accountTradingCurrencyType} yang dimiliki PT Delapan Belas FX", title: "Pilih Rekening", list: List.generate(tradingAccountController.bankAdminModels.value?.response.length ?? 0, (i){
                          return CupertinoActionSheetAction(
                            onPressed: (){
                              bankAdminID(tradingAccountController.bankAdminModels.value!.response[i].id);
                              namaBankPenerima.text = tradingAccountController.bankAdminModels.value?.response[i].bankName ?? '';
                              nomorRekeningPenerima.text = tradingAccountController.bankAdminModels.value?.response[i].bankAccount ?? '';
                              namaBankPenerima.text = tradingAccountController.bankAdminModels.value?.response[i].bankHolder ?? "";
                              Navigator.pop(context);
                            },
                            child: Text(tradingAccountController.bankAdminModels.value?.response[i].bankHolder ?? ''),
                          );
                        }));
                      }),
                      CustomCupertinoFormRow(controller: namaBankPenerima, readOnly: true, prefix: "Nama Bank Holder", placeholder: "Select Bank Option first"),
                      CustomCupertinoFormRow(controller: nomorRekeningPenerima, readOnly: true, prefix: "Nomor Rekening", placeholder: "Select Bank Option first"),
                    ],
                  ),
                ),
                Obx(
                  () => isLoading.value ? const SizedBox() : CustomCupertinoListSectionInsertGroup(
                    // footer: "Transaksi anda akan diterima oleh admin perusahaan, mohon isikan semua data dengan benar dan dapat dipertanggung jawabkan.",
                    header: "Bank Pengirim",
                    footer: "Isikan semua field dengan informasi yang benar dan dapat dipertanggung jawabkan kebenaranya.\nBalance USD yang akan anda terima sebesar ${tradingAccountController.moneyConversionModels.value?.response.amountReceived}",
                    children: [
                      Obx(
                        () => CustomCupertinoFormRow(controller: pilihanBankPengirim, readOnly: true, prefix: "Pilih Bank", placeholder: "Select here", onPressed: tradingAccountController.isLoading.value ? null : (){
                          showActionSheet(context, message: "Pilih rekening bank yang anda miliki", title: "Pilih Rekening", list: List.generate(tradingAccountController.bankUserModels.value?.response.length ?? 0, (i){
                            return CupertinoActionSheetAction(
                              onPressed: (){
                                if(tradingAccountController.bankUserModels.value != null){
                                  selectedUserBankID(tradingAccountController.bankUserModels.value?.response[i].id);
                                  pilihanBankPengirim.text = tradingAccountController.bankUserModels.value!.response[i].name!;
                                  nomorRekeningPengirim.text = tradingAccountController.bankUserModels.value!.response[i].account!;
                                  namaBankPengirim.text = tradingAccountController.bankUserModels.value!.response[i].userName!;
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(tradingAccountController.bankUserModels.value!.response[i].name!),
                            );
                          }));
                        }),
                      ),
                      CustomCupertinoFormRow(controller: namaBankPengirim, readOnly: true, prefix: "Nama Pemilik Rekening", placeholder: "Select Bank Option first"),
                      CustomCupertinoFormRow(controller: nomorRekeningPengirim, readOnly: true, prefix: "Nomor Rekening", placeholder: "Select Bank Option first"),
                      CustomCupertinoFormRow(controller: akunTradingPengirim, readOnly: true, prefix: "ID Akun Trading", placeholder: "Select Real Account", onPressed: (){}),
                      CustomCupertinoFormRow(controller: rate, readOnly: true, prefix: "Rate Akun Trading", placeholder: "Rate Info"),
                      CustomCupertinoFormRow(controller: jumlahBalance, readOnly: true, prefix: "Jumlah Balance Akun Trading", placeholder: "0", prefixWidget: const Text("USD", style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 15))),
                      CustomCupertinoFormRowCurrency(controller: jumlahDepositPengirim, readOnly: false, prefix: "Jumlah Deposit", textInputType: TextInputType.number, currencyType: widget.accountTradingCurrencyType, textInputAction: TextInputAction.done, onFieldSubmitted: (value){
                        if(value != "" || value.isNotEmpty){
                          tradingAccountController.moneyConversion(amount: value, tradingID: widget.akunTradingID, type: "deposit").then((result){
                            if(result){
                              if(kDebugMode) print(tradingAccountController.moneyConversionModels.value?.response.amountReceived);
                            }
                          });
                        }
                      }),
                      CustomCupertinoFormRow(controller: transactionProof, readOnly: true, prefix: "Bukti Transfer", placeholder: "Ambil Gambar", onPressed: (){
                        showActionSheet(
                          context,
                          title: "Pilih Metode",
                          message: "Ambil gambar melalui",
                          list: [
                            CupertinoActionSheetAction(
                              onPressed: (){
                                Navigator.pop(context);
                                getFromGallery();
                              },
                              child: const Text("Galeri"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: (){
                                Navigator.pop(context);
                                getFromCamera();
                              },
                              child: const Text("Kamera"),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  if(pathImage.value != ""){
                    return CupertinoButton(child: Text("Lihat Gambar", style: TextStyle(color: GlobalVariablesType.mainColor)), onPressed: (){Get.to(() => PhotoViewer(pathImage: pathImage.value));});
                  }
                  return const SizedBox();
                })
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
                    // print("userToken => ${accountsController.userToken.value}");
                    // print("amount => ${jumlahDepositPengirim.text}");
                    // print("bankAdminID => ${bankAdminID.value}");
                    // print("userBankID => ${selectedUserBankID.value}");
                    // print("tradingID => ${widget.akunTradingID}");
                    // print("URLImage => ${pathImage.value}");
                    
                    tradingAccountController.deposit(
                      amount: jumlahDepositPengirim.text,
                      bankAdminID: bankAdminID.value,
                      tradingID: widget.akunTradingID,
                      urlImage: pathImage.value,
                      userBankID: selectedUserBankID.value
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
                child: tradingAccountController.isLoading.value ? const CupertinoActivityIndicator(color: Colors.black) : const Text("Deposit", style: TextStyle(color: CupertinoColors.black))
              ),
            ),
          ),
        ),
      ),
    );
  }

  RxString pathImage = "".obs;
  // Fungsi Mengambil gambar melalui kamera
  Future<dynamic> getFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if(imagePicked != null){
      pathImage(imagePicked.path);
      transactionProof.text = imagePicked.name;
    }
  }

  // Fungsi Mengambil gambar melalui galery
  Future<dynamic> getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(imagePicked != null){
      pathImage(imagePicked.path);
      transactionProof.text = imagePicked.name;
    }
  }
}