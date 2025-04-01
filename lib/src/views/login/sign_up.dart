import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/views/login/otp.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({super.key});

  @override
  State<SignUpPages> createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ID';
  // PhoneNumber number = PhoneNumber(isoCode: 'ID');
  // String? finalNumber;

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ID');

  //   setState(() {
  //     this.number = number;
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
          backgroundColor: Colors.white,
        appBar: kDefaultAppBarCustom(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text("REGISTER", style: kDefaultTextStyleSubtitleSplashScreen(color: Colors.black87)),
                ),
                const SizedBox(height: 15),
                Center(child: Image.asset('assets/images/register_image.png')),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text("Enter your mobile number", style: kDefaultTextStyleCustom(color: Colors.black, fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text("Please confirm your country code and enter your mobile number, we will send OTP to your WhatsApp number", style: kDefaultTextStyleCustom(color: Colors.black54, fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: PhoneTextField(
                    controller: controller,
                    hintText: "Example +62xxx",
                  ),  
                )
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                //   child: InternationalPhoneNumberInput(
                //     onInputChanged: (PhoneNumber number) {
                //       setState(() {
                //         finalNumber = number.phoneNumber;
                //       });
                //       print(number.phoneNumber);
                //     },
                //     selectorConfig: const SelectorConfig(
                //       selectorType: PhoneInputSelectorType.DIALOG,
                //       useBottomSheetSafeArea: true,
                //     ),
                //     ignoreBlank: false,
                //     searchBoxDecoration: const InputDecoration(
                //       border: UnderlineInputBorder(),
                //       hintText: "Search"
                //     ),
                //     autoValidateMode: AutovalidateMode.disabled,
                //     selectorTextStyle: const TextStyle(color: Colors.black),
                //     initialValue: number,
                //     textFieldController: controller,
                //     formatInput: true,
                //     keyboardType:
                //         const TextInputType.numberWithOptions(signed: true, decimal: true),
                //     inputBorder: const UnderlineInputBorder(),
                //   ),
                // ),
              ],
            ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: kDefaultButtonLogin(
              onPressed: (){
                Get.to(() => const OTPPage());
              },
              title: "C O N T I N U E"
            ),
          ),
        ),
      ),
    );
  }
}