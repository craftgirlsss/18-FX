import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/controllers/trading_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InternalTransfer extends StatefulWidget {
  final String? accountNumber;
  final String? accountTypeName;
  final String? balance;
  final String? accountCurrency;
  const InternalTransfer({super.key, this.accountNumber, this.accountTypeName, this.balance, this.accountCurrency});

  @override
  State<InternalTransfer> createState() => _InternalTransferState();
}

class _InternalTransferState extends State<InternalTransfer> {
  PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();
  TradingAccountController tradingAccountController = Get.find();
  TextEditingController amountTransfer = TextEditingController();
  RxDouble currentPage = 0.0.obs;
  RxList listAccountReal = [].obs;
  RxBool isLoading = false.obs;
  RxInt selectedAccountIndex = 0.obs;

  @override
  void initState() {
    pageController.addListener((){
      currentPage(pageController.page);
    });
    super.initState();
    Future.delayed(Duration.zero, (){
      isLoading(true);
      tradingAccountController.getListAccountTrading().then((result){
        if(!result){
          alertError(
            title: "Gagal",
            message: tradingAccountController.responseMessage.value,
            onTap: () => Navigator.pop(context)
          );
        }else{
          for(int i = 0; i < tradingAccountController.listTradingAccount.value!.response.length; i++){
            if(tradingAccountController.listTradingAccount.value?.response[i].type == "real"){
              if(tradingAccountController.listTradingAccount.value?.response[i].login != widget.accountNumber){
                listAccountReal.add({
                  "login" : tradingAccountController.listTradingAccount.value?.response[i].login,
                  "balance" : tradingAccountController.listTradingAccount.value?.response[i].balance,
                  "currency" : tradingAccountController.listTradingAccount.value?.response[i].currency,
                  "namaTipeAkun" : tradingAccountController.listTradingAccount.value?.response[i].namaTipeAkun,
                });
              }
            }
          }
        }
        isLoading(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transfer"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cardAccount(balance: widget.balance, accountNumber: widget.accountNumber, accountTypeName: widget.accountTypeName, size: size, currency: widget.accountCurrency),
              const SizedBox(height: 15),
              Obx(
                () => isLoading.value ? const SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white60),
                      SizedBox(height: 10),
                      Text("Mendapatkan Akun...", style: TextStyle(color: Colors.white60, fontSize: 13))
                    ],
                  ),
                ) : listAccountReal.length < 2 ? const SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Iconsax.empty_wallet_add_outline, color: Colors.white60, size: 35),
                      SizedBox(height: 10),
                      Text("Akun real anda kurang dari 2", style: TextStyle(color: Colors.white60, fontSize: 13))
                    ],
                  ),
                ) : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(MingCute.transfer_vertical_line, color: Colors.white60, size: 50),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.width / 2.5,
                      child: Obx(
                        () => PageView.builder(
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: listAccountReal.length,
                          onPageChanged: (value) {
                            selectedAccountIndex(value);
                          },
                          itemBuilder: (context, index) {
                            return cardAccount(size: size, position: "To", accountNumber: listAccountReal[index]['login'], accountTypeName: listAccountReal[index]['namaTipeAkun'], balance: listAccountReal[index]['balance'], currency: listAccountReal[index]['currency']);
                          },
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: listAccountReal.length,
                      effect: const WormEffect(
                        dotHeight: 5,
                        dotWidth: 20,
                        activeDotColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Obx(
                        () => isLoading.value ? const SizedBox() : Form(
                          key: formKey,
                          child: AnyTextField(
                            prefix: const Text("\$ ", style: TextStyle(color: Colors.white, fontSize: 13),),
                            textInputType: TextInputType.number,
                            controller: amountTransfer,
                            hintText: "Jumlah Transfer",
                            labelText: "Jumlah Transfer (USD)",
                            withValidator: true,
                            iconData: Iconsax.dollar_circle_bold,
                          ),
                        ),
                      ),
                    )
                
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Obx(() => isLoading.value ? const SizedBox() : kDefaultButtonLogin(
              onPressed: tradingAccountController.isLoading.value ? (){} : (){
                if(listAccountReal.length > 1){
                  if(formKey.currentState!.validate()){
                    double balanceFrom = double.parse(widget.balance!);
                    double balanceInputted = double.parse(amountTransfer.text);
                    if(balanceInputted > balanceFrom){
                      alertError(title: "Gagal", message: "Balance yang diinputkan melebihi balance akun yang dimiliki", onTap: (){Navigator.pop(context);});
                    }else{
                      tradingAccountController.internalTransfer(
                        accountFrom: widget.accountNumber,
                        accountTo: listAccountReal[selectedAccountIndex.value]['login'],
                        amount: balanceInputted.toString()
                      ).then((result){
                        if(result){
                          alertDialogCustomSuccess(
                            message: tradingAccountController.responseMessage.value,
                            title: "Berhasil",
                            onTap: (){Navigator.of(context)..pop()..pop();}
                          );
                        }else{
                          alertError(title: "Gagal", message: tradingAccountController.responseMessage.value, onTap: (){Navigator.pop(context);});
                        }
                      });
                    }
                  }
                }else{
                  alertError(title: "Gagal", message: "Akun anda kurang dari 2, anda tidak bisa melakukan transaksi", onTap: (){Navigator.pop(context);});
                }
              },
              title: tradingAccountController.isLoading.value ? "Memproses..." : "Transfer",
            )),
          ),
        ),
      )
    );
  }

  Widget cardAccount({Size? size, String? accountTypeName, String? balance, String? accountNumber, String? position, String? currency}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(position ?? "From", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white60, fontSize: 18)),
        ),
        Container(
          width: size!.width,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white30),
            boxShadow: const [BoxShadow(color: Colors.white54, blurRadius: 3, offset: Offset(3, 3))]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(accountTypeName ?? "Lite", style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(width: 10),
                  Text(accountNumber ?? "0", style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              Text("\$${balance ?? "0"}", style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 35)),
              Text(currency ?? 'N/A', style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ),
      ],
    );
  }
}