import 'dart:async';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/views/login/view_stepper_trial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, this.phone, this.email, this.normalyRegisteredProcess, this.name});
  final String? phone;
  final String? email;
  final String? name;
  final bool? normalyRegisteredProcess;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  AccountsController accountsController = Get.find();
  OtpFieldController otpController = OtpFieldController();
  String? otpResult;
  bool enableResend = false;
  Timer? timer;
  RxBool showResendButton = false.obs;
  RxBool showTimer = false.obs;
  RxInt secondsRemaining = 90.obs;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        setState(() {
          secondsRemaining.value--;
        });
      } else {
          timer?.cancel();
          showTimer(false);
          showResendButton(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: GlobalVariablesType.backgroundColor,
            appBar: kDefaultAppBarCustom(context),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: Text("Verifikasi Kode OTP", style: kDefaultTextStyleSubtitleSplashScreen()),
                    ),
                    const SizedBox(height: 15),
                    Center(child: Image.asset('assets/images/otp_image.png')),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: Text("Masukkan kode OTP", style: kDefaultTextStyleCustom(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: Text("Masukkan kode OTP yang dikirimkan melalui SMS ke nomor ${widget.phone}", style: const TextStyle(color: Colors.white38, fontSize: 15),),
                    ),
                    const SizedBox(height: 20),   
                    Center(
                      child: OTPTextField(
                        otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: GlobalVariablesType.mainColor,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          borderColor: Colors.white.withOpacity(0.2),
                          enabledBorderColor: Colors.white.withOpacity(0.2),
                        ),
                        controller: otpController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceEvenly,
                        fieldWidth: 45,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 10,
                        style: kDefaultTextStyleCustom(fontSize: 17),
                        onChanged: (pin) {
                        },
                        onCompleted: (pin) {
                          // otpController.clear();
                          setState(() {
                            otpResult = pin;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if(secondsRemaining.value == 0){
                        showTimer(false);
                        showResendButton(true);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Tidak menerima kode OTP?", style: TextStyle(color: Colors.white)),
                            CupertinoButton(child: Text("Kirim Ulang", style: TextStyle(color: GlobalVariablesType.mainColor)), onPressed: () async {
                              if(secondsRemaining.value == 0){
                                await accountsController.resendOTP(email: widget.email).then((result){
                                  if(result){
                                    secondsRemaining(90);
                                    resendCode();
                                    Get.snackbar("Berhasil", accountsController.responseMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
                                  }else{
                                    alertError(
                                      title: "Gagal",
                                      message: accountsController.responseMessage.value.capitalize,
                                      onTap: (){
                                        Navigator.pop(context);
                                      }
                                    );
                                  }
                                });
                              }
                            })
                          ],
                        );
                      }else{
                        showTimer(true);
                        showResendButton(false);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            const Text("Waktu tersisa : ", style: TextStyle(color: Colors.white)),
                            Text("${secondsRemaining.value ~/ 60}:${secondsRemaining.value % 60} detik", style: TextStyle(color: GlobalVariablesType.mainColor))
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Obx(
                  () => kDefaultButtonLogin(
                    onPressed: accountsController.isLoading.value ? (){} : secondsRemaining.value == 0 ? null : () async {
                      if(await accountsController.confirmOTP(email: widget.email, otp: otpResult) == true){
                        alertDialogCustomSuccess(
                          message: accountsController.responseMessage.value,
                          onTap: (){
                            if(widget.normalyRegisteredProcess == true){
                              Get.off(() => const StepperTrialPage(
                                normalyRegisteredProcess: true,
                                fromLogin: true,
                                currentStep: 1,
                                loginWithGoogle: false,
                                registerWithGoogle: false,
                              ));
                            }else{
                              Get.off(() => const StepperTrialPage(
                                normalyRegisteredProcess: false,
                                fromLogin: false,
                                currentStep: 1,
                                loginWithGoogle: false,
                                registerWithGoogle: false,
                              ));
                            }
                          }
                        );
                      }else{
                        alertError(
                          title: "Gagal",
                          message: accountsController.responseMessage.value.capitalize,
                          onTap: () {
                            Navigator.pop(context);
                          }
                        );
                      }
                      // var email = accountsController.emailTemp.value;
                      // var passwd = accountsController.passwordTemp.value;
                      // if(email == ""){
                      //   SharedPreferences prefs = await SharedPreferences.getInstance();
                      //   String? emailPrefs = prefs.getString('email');
                      //   if(kDebugMode) print("ini email preference hasil dari register manual => $emailPrefs");
                      //   if(emailPrefs != null){
                      //     if(await accountsController.confirmOTP(
                      //         email: emailPrefs,
                      //         otp: otpResult
                      //     ) == true){
                      //       Get.off(() => const StepperTrialPage(
                      //         fromLogin: false,
                      //         currentStep: 1,
                      //         loginWithGoogle: false,
                      //         registerWithGoogle: false,
                      //       ));
                      //     }
                      //   }
                      // }else{
                      //   if(kDebugMode) print("ini masuk ke else karena emailTemp tidak kosong");
                      //   if(kDebugMode) print("ini email temporary hasil dari register manual => $email");
                      //   if(kDebugMode) print("ini password temporary hasil dari register manual => $passwd");
                      //   if(await accountsController.confirmOTP(
                      //     email: email,
                      //     otp: otpResult
                      //   ) == true){
                      //     Get.off(() => const StepperTrialPage(
                      //       fromLogin: false,
                      //       currentStep: 1,
                      //       registerWithGoogle: false,
                      //       loginWithGoogle: false,
                      //     ));
                      //   }
                      // }
                    },
                    title: "Submit"
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() => accountsController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }

  void resendCode() {
    //other code here
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        timer?.cancel();
        showTimer(false);
        showResendButton(true);
      }
    });
    setState((){
      enableResend = false;
    });
  }  
  
  @override
  dispose(){
    timer?.cancel();
    super.dispose();
  }
}