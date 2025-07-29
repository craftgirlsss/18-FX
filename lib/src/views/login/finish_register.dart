import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/views/login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailContrller = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController firstNameContrller = TextEditingController();
  TextEditingController lastNameContrller = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailContrller.dispose();
    referalCodeController.dispose();
    firstNameContrller.dispose();
    lastNameContrller.dispose();
    noHPController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: kDefaultAppBarGoBackOnly(context),
        body: ListView(
          padding: GlobalVariablesType.defaultPadding,
          children: [
            const SizedBox(height: 20),
            Text(GlobalVariablesType.ucapanSignUp, style: kDefaultTextStyleSubtitleSplashScreen(color: Colors.black87)),
            const SizedBox(height: 15),
            NameTextField(
              hintText: "Input your name",
              labelText: "Full Name",
              controller: firstNameContrller,
            ),
            const SizedBox(height: 15),
            EmailTextField(
              hintText: "Input your email",
              labelText: "Email",
              controller: emailContrller,
            ),
            const SizedBox(height: 15),
            TextEditingOptionSelect(
              controller: birthDateController,
              labelText: "Birth Date",
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000), //get today's date
                  firstDate:DateTime(1960), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now()
                );
                if(pickedDate != null ){                      
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  setState(() {
                      birthDateController.text = formattedDate; //set foratted date to TextField value. 
                  });
                }else{
                    Get.snackbar("Failed", "Please choose your birthdate");
                }
              },
            ),
            const SizedBox(height: 15),
            AnyTextField(
              hintText: "Referal Code",
              labelText: "Referal Code",
              controller: referalCodeController,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      CupertinoCheckbox(
                        activeColor: GlobalVariablesType.buttonTextColor![3],
                        value: isChecked, 
                        onChanged: (bool? value){
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                        Text(GlobalVariablesType.agreeText, style: kDefaultTextStyleButtonText(color: GlobalVariablesType.buttonTextColor![3]),)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: kDefaultButtonLogin(
                title: GlobalVariablesType.signUpText,
                onPressed: (){
                  Get.offAll(() => const LoginPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}