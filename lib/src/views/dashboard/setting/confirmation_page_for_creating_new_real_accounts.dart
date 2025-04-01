import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/views/mainpage.dart';

class ConfirmationPageForCreatingNewRealAccounts extends StatefulWidget {
  final String? titleAppBar;
  const ConfirmationPageForCreatingNewRealAccounts({super.key, this.titleAppBar});

  @override
  State<ConfirmationPageForCreatingNewRealAccounts> createState() => _ConfirmationPageForCreatingNewRealAccountsState();
}

class _ConfirmationPageForCreatingNewRealAccountsState extends State<ConfirmationPageForCreatingNewRealAccounts> {
  AccountsController accountsController = Get.put(AccountsController());
  TextEditingController leverageController = TextEditingController();
  bool realAccountChoosed = true;
  String dropDownValueWeek = '1:500';
  // List of items in our dropdown Today menu 
  var itemsLeverage = [     
    '1:500', 
    '1:200', 
    '1:100', 
    '1:50', 
    '1:25',
    '1:15',
    '1:5',
    '1:1' 
  ]; 

  String dropDownValueRate = 'Rp. 10.000';
  // List of items in our dropdown Today menu 
  var itemsFixRate = [     
    'Rp. 10.000', 
    'Rp. 12.000', 
    'Rp. 14.000', 
  ];

  @override
  void dispose() {
    leverageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, title: Text(widget.titleAppBar ?? 'Unknown', style: kDefaultTextStyleCustom(fontSize: 15))),
      body: SingleChildScrollView(
        padding: GlobalVariablesType.defaultPadding,
        child: Column(
          children: [
            Row(
              children: [
                Text("Account Type", style: kDefaultTextStyleCustom(fontSize: 14),),
                IconButton(onPressed: (){
                  Get.defaultDialog(
                    contentPadding: const EdgeInsets.all(15),
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    title: "Account Type",
                    titleStyle: kDefaultTextStyleCustom(fontSize: 15),
                    content: Text("If you choose your account as demo, your newly opened account will be denominated in virtual funds and allow you to trade risk free.", style: kDefaultTextStyleCustom(fontSize: 13, fontWeight: FontWeight.normal)),
                    actions: [
                      kDefaultButtonLogin(
                        title: "OK",
                        onPressed: () => Navigator.pop(context)
                      )
                    ]
                  );
                }, icon: const Icon(CupertinoIcons.question_circle, color: Colors.white,),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              realAccountChoosed = true;
                            });
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: realAccountChoosed == true ? GlobalVariablesType.mainColor : Colors.white,
                            shape: const StadiumBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.white
                              )
                            ),
                          ),
                          child: Text("Real", style: kDefaultTextStyleCustom(color: Colors.black)))),
                        const SizedBox(width: 5),
                        Expanded(child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              realAccountChoosed = false;
                            });
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: realAccountChoosed == false ? GlobalVariablesType.mainColor : Colors.white,
                            shape: const StadiumBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.white
                              )
                            ),
                          ),
                          child: Text("Demo", style: kDefaultTextStyleCustom(color: Colors.black))))
                      ],
                    ),
                ),
              ],
            ),


            Row(
              children: [
                Text("Leverage", style: kDefaultTextStyleCustom(fontSize: 14),),
                IconButton(onPressed: (){
                  Get.defaultDialog(
                    contentPadding: const EdgeInsets.all(15),
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    title: "Leverage",
                    titleStyle: kDefaultTextStyleCustom(fontSize: 15),
                    content: Text("You can change the leverage later when you log in into your accounts. Please note thaht you'll need to close your opened orders or cancle pending orders before adjusting the leverage", style: kDefaultTextStyleCustom(fontSize: 13, fontWeight: FontWeight.normal)),
                    actions: [
                      kDefaultButtonLogin(
                        title: "OK",
                        onPressed: () => Navigator.pop(context)
                      )
                    ]
                  );
                }, icon: const Icon(CupertinoIcons.question_circle, color: Colors.white,),)
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: CupertinoColors.darkBackgroundGray, 
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.3, color: Colors.white24),
              ),
              child: DropdownButton(
                style: kDefaultTextStyleCustom(fontSize: 16),
                isExpanded: true,
                dropdownColor: CupertinoColors.darkBackgroundGray,
                borderRadius: BorderRadius.circular(15),
                underline: const SizedBox(),
                value: dropDownValueWeek,                           
                icon: const Icon(Icons.keyboard_arrow_down),     
                items: itemsLeverage.map((String items) { 
                  return DropdownMenuItem( 
                    value: items, 
                    child: Text(items, style: kDefaultTextStyleCustom(),), 
                  ); 
                }).toList(), 
                onChanged: (String? newValue) {  
                  setState(() { 
                    dropDownValueWeek = newValue!; 
                    }); 
                  }, 
                ),
              ),
              const SizedBox(height: 10),
              Row(
              children: [
                Text("Fixed Rate", style: kDefaultTextStyleCustom(fontSize: 14),),
                IconButton(onPressed: (){
                  Get.defaultDialog(
                    contentPadding: const EdgeInsets.all(15),
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    title: "Fixed Rate",
                    titleStyle: kDefaultTextStyleCustom(fontSize: 15),
                    content: Text("Fixed rate is a feature that allows you to transfer your local currency into your trading USD-account and from it under a set (fixed) rate without conversion expenses. For example (Rp.10.000 = 1\$ USD)", style: kDefaultTextStyleCustom(fontSize: 13, fontWeight: FontWeight.normal)),
                    actions: [
                      kDefaultButtonLogin(
                        title: "OK",
                        onPressed: () => Navigator.pop(context)
                      )
                    ]
                  );
                }, icon: const Icon(CupertinoIcons.question_circle, color: Colors.white,),)
              ],
            ),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: CupertinoColors.darkBackgroundGray, 
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.3, color: Colors.white24),
            ),
            child: DropdownButton(
              style: kDefaultTextStyleCustom(fontSize: 16),
              isExpanded: true,
              dropdownColor: CupertinoColors.darkBackgroundGray,
              borderRadius: BorderRadius.circular(15),
              underline: const SizedBox(),
              value: dropDownValueRate,                           
              icon: const Icon(Icons.keyboard_arrow_down),     
              items: itemsFixRate.map((String items) { 
                return DropdownMenuItem( 
                  value: items, 
                  child: Text(items, style: kDefaultTextStyleCustom(),), 
                ); 
              }).toList(), 
              onChanged: (String? newValue) {  
                setState(() { 
                  dropDownValueRate = newValue!; 
                  }); 
                }, 
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(15), child: Obx(() => kDefaultButtonLogin(onPressed: accountsController.isLoading.value == true ? (){} : ()async{
        accountsController.haveAccount.value = true;
        Get.snackbar("Berhasil",
              "Berhasil membuat akun",
              backgroundColor: Colors.white, colorText: Colors.black87);
        Future.delayed(const Duration(seconds: 2)).then((value) => Get.offAll(() => const MainPage()));
      }, title: "Create Trading Account")),),
    );
  }
}