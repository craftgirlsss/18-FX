import 'dart:async';
import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/helpers/phone_code.dart';
import 'package:delapanbelasfx/src/views/login/view_stepper_trial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/helpers/validate_password.dart';
import 'package:icons_plus/icons_plus.dart';

class RegisterAccountV2 extends StatefulWidget {
  const RegisterAccountV2({super.key});

  @override
  State<RegisterAccountV2> createState() => _RegisterAccountV2State();
}

class _RegisterAccountV2State extends State<RegisterAccountV2> {
  AccountsController accountsController = Get.find();
  final formKey = GlobalKey<FormState>();
  RxString dropdownValue = "".obs;
  RxInt selectedPhone = 95.obs;
  PhoneUtils phoneUtils = PhoneUtils();
  bool isChecked = false;
  TextEditingController emailContrller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isEightCharacter = false;
  RxBool showOTPField = false.obs;

  bool tampilsandipasswordsekarang = true;
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;
  bool hasPasswordSame = false;
  bool hasSymbols = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final upperLowerRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');
    final symbolsRegex = RegExp(r'[^\w\s]');
    
    setState(() {
      isPasswordEightCharacters = false;
      if (password.length > 7) isPasswordEightCharacters = true;

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) hasPasswordOneNumber = true;
      
      hasSymbols = false;
      if(symbolsRegex.hasMatch(password)) hasSymbols = true;
    });
    hasLowerUpper = false;
    if (upperLowerRegex.hasMatch(password)) hasLowerUpper = true;
  }

  onPasswordChangeConfirm(String password1, String password2){
    setState(() {
      hasPasswordSame = false;
      if (password1 == password2) hasPasswordSame = true;
    });
  }

  Timer? timer;
  RxBool showTimer = false.obs;
  RxInt secondsRemaining = 0.obs;
  RxBool showResendButton = false.obs;

  void resendCode() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        timer?.cancel();
        showTimer(false);
        showResendButton(true);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {});
    confirmPasswordController.addListener(() {});
  }

  @override
  void dispose() {
    emailContrller.dispose();
    passwordController.dispose();
    nameController.dispose();
    referalController.dispose();
    confirmPasswordController.dispose();
    noHPController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    dropdownValue(phoneUtils.countryCode[0]['code']);
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: GlobalVariablesType.backgroundColor,
            appBar: kDefaultAppBarCustom(context, actions: [
              CupertinoButton(child: Icon(CupertinoIcons.info, color: GlobalVariablesType.mainColor), onPressed: (){
                alertDialogCustomInfo(
                  title: "Informasi",
                  message: "Penuhi semua field terlebih dahulu kecuali OTP, karena waktu tunggu OTP hanya 90 detik. Jika waktu tunggu OTP sudah berakhir, maka anda tidak bisa submit form",
                  onTap: (){
                    Navigator.pop(context);
                  }
                );
              })
            ]),
            body: Form(
              key: formKey,
              child: ListView(
                padding: GlobalVariablesType.defaultPadding,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ic_launcher.png', width: size.width / 6, height: size.width / 6),
                      const SizedBox(height: 15),
                      Text("Registrasi", style: kDefaultTextStyleSubtitleSplashScreen()),
                      SizedBox(
                        width: size.width / 1.5,
                        child: const Text("Raih peluang investasi dengan bergabung bersama 18 FX", style: TextStyle(color: Colors.white38), textAlign: TextAlign.center,)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  NameTextField(
                    hintText: "Input nama lengkap anda",
                    labelText: "Nama Lengkap*",
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  EmailTextField(
                    hintText: "example@email.com",
                    labelText: "Alamat Email*",
                    controller: emailContrller,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        onPressed: (){
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) => Container(
                              height: 216,
                              padding: const EdgeInsets.only(top: 6.0),
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              color: CupertinoColors.black,
                              child: SafeArea(
                                top: false, 
                                child: CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: 32.0,
                                  scrollController: FixedExtentScrollController(initialItem: selectedPhone.value),
                                  onSelectedItemChanged: (int selectedItem) {
                                    selectedPhone(selectedItem);
                                  },
                                  children: List<Widget>.generate(phoneUtils.countryCode.length, (int index) {
                                    return Center(child: Text("+${phoneUtils.countryCode[index]['code']} - ${phoneUtils.countryCode[index]['country']}", style: const TextStyle(color: Colors.white),));
                                  }),
                                )
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: 60,
                          height: 40,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: GlobalVariablesType.mainColor.withOpacity(0.3),
                            border: Border.all(color: GlobalVariablesType.mainColor)
                          ),
                          child: Center(child: Obx(() => Text(selectedPhone.value == 0 ? "+62" : "+${phoneUtils.countryCode[selectedPhone.value]['code']}", style: TextStyle(color: GlobalVariablesType.mainColor, fontSize: 15), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,))),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Obx(
                          () => PhoneTextField(
                            hintText: "81xx",
                            forOTP: true,
                            onTapSendOTP: accountsController.isLoading.value || secondsRemaining.value > 0 ? null : (){
                              accountsController.sendOTP(phone: noHPController.text, phoneCode: phoneUtils.countryCode[selectedPhone.value]['code']).then((result){
                                if(result){
                                  secondsRemaining(90);
                                  resendCode();
                                  showOTPField(true);
                                }else{
                                  showOTPField(false);
                                  alertError(title: "Galat", message: accountsController.responseMessage.value, onTap: () => Navigator.pop(context));
                                }
                              });
                            },
                            labelText: "Nomor HP*",
                            controller: noHPController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => AnimatedOpacity(
                      opacity: secondsRemaining.value > 0 ? 1 : 0,
                      duration: const Duration(seconds: 2),
                      child: secondsRemaining.value > 0 ? AnyTextField(
                        withOptionalText: false,
                        textInputType: TextInputType.number,
                        iconData: Bootstrap.number_123,
                        prefixText: secondsRemaining.value == 0 ? "" : "${secondsRemaining.value ~/ 60}:${secondsRemaining.value % 60} detik",
                        controller: otpController,
                        hintText: "Inputkan kode OTP",
                        labelText: "Kode OTP*",  
                      ) : const SizedBox(),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: tampilsandipasswordbaru1,
                    keyboardAppearance: Brightness.dark,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isikan Kata Sandi';
                      }
                      return null;
                    },
                    style: kDefaultTextStyleCustom(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "Atur kata sandi akun anda",
                      prefixIcon: Icon(Icons.password, color: GlobalVariablesType.mainColor),
                      errorStyle: kDefaultTextStyleCustom(color: Colors.red),
                      labelText: "Kata Sandi*",
                      labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
                      hintStyle: TextStyle(color: Colors.white24, fontSize: GlobalVariablesType.defaultFontSize),
                      filled: false,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            tampilsandipasswordbaru1 = !tampilsandipasswordbaru1;
                          });
                        },
                        child: tampilsandipasswordbaru1 == true ?  Icon(Icons.visibility, color: GlobalVariablesType.mainColor) :  Icon(Icons.visibility_off, color: GlobalVariablesType.mainColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      )
                    ),
                    onChanged: (text) => onPasswordChanged(text),
                  ),
                  const SizedBox(height: 15),
                  Roweliminatenumber(
                  isPasswordEightCharacters: isPasswordEightCharacters),
                  const SizedBox(height: 10),
                  Roweliminatelowup(hasLowerUpper: hasLowerUpper),
                  const SizedBox(height: 10),
                  Roweliminateonenum(hasPasswordOneNumber: hasPasswordOneNumber),
                  const SizedBox(height: 10),
                  RoweliminateSamePassword(isPasswordSameWithOther: hasPasswordSame),
                  const SizedBox(height: 10),
                  RoweliminateSymbols(hasLowerUpper: hasSymbols),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: tampilsandipasswordbaru2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardAppearance: Brightness.dark,
                    style: kDefaultTextStyleCustom(fontSize: 13),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isikan Konfirmasi Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Ketik ulang kata sandi",
                      prefixIcon: Icon(Icons.password, color: GlobalVariablesType.mainColor),
                      errorStyle: kDefaultTextStyleCustom(color: Colors.red),
                      labelText: "Konfirmasi Kata Sandi*",
                      labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
                      hintStyle: TextStyle(color: Colors.white38, fontSize: GlobalVariablesType.defaultFontSize),
                      filled: false,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            tampilsandipasswordbaru2 = !tampilsandipasswordbaru2;
                          });
                        },
                        child: tampilsandipasswordbaru2 == true ?  Icon(Icons.visibility, color: GlobalVariablesType.mainColor) :  Icon(Icons.visibility_off, color: GlobalVariablesType.mainColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:GlobalVariablesType.mainColor
                        )
                      )
                    ),
                    onChanged: (text) => onPasswordChangeConfirm(passwordController.text, text),
                  ),
                  const SizedBox(height: 15),
                  AnyTextField(
                    withOptionalText: true,
                    iconData: MingCute.coupon_fill,
                    controller: referalController,
                    hintText: "Inputkan kode referal jika anda memilikinya.",
                    labelText: "Kode Referal (optional)",  
                  ),
                  const SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       color: Colors.transparent,
                  //       child: Row(
                  //         children: [
                  //           CupertinoCheckbox(
                  //             activeColor: GlobalVariablesType.buttonTextColor![3],
                  //             value: isChecked, 
                  //             onChanged: (bool? value){
                  //               setState(() {
                  //                 isChecked = value!;
                  //               });
                  //             }),
                  //             GestureDetector(
                  //               onTap: (){
                  //                 launchUrls(GlobalVariablesType.termsAndConditions);
                  //               },
                  //               child: Text(GlobalVariablesType.agreeText!, style: kDefaultTextStyleButtonText(color: GlobalVariablesType.mainColor),))
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Obx(
                () => kDefaultButtonLogin(
                  title: GlobalVariablesType.signUpText,
                  onPressed: accountsController.isLoading.value ? (){} : secondsRemaining.value < 1 ? null : () async {
                    if(formKey.currentState!.validate()){
                      if(hasPasswordSame && hasLowerUpper && hasPasswordOneNumber){
                        accountsController.emailRegisterTemp.value = nameController.text;
                        accountsController.fullNameRegisterTemp.value = nameController.text;
                        accountsController.register(
                          email: emailContrller.text,
                          otp: otpController.text,
                          name: nameController.text,
                          password: confirmPasswordController.text,
                          phoneCode: phoneUtils.countryCode[selectedPhone.value]['code'],
                          phoneNumber: noHPController.text,
                          referalCode: referalController.text
                        ).then((result){
                          if(result){
                            if(kDebugMode) print("berhasil karena response dari api => $result");
                              alertDialogCustomSuccess(
                                title: "Berhasil",
                                message: "Akun anda berhasil dibuat, anda akan diarahkan ke Form Pengisian Detail Akun dengan menekan tombol Lanjutkan",
                                onTap: () {
                                  Get.to(() => StepperTrialPage(
                                    email: emailContrller.text,
                                    name: nameController.text,
                                    normalyRegisteredProcess: true,
                                    phone: "${phoneUtils.countryCode[selectedPhone.value]['code']}${noHPController.text}",
                                    fromLogin: false,
                                    registerWithGoogle: false,
                                    loginWithGoogle: false,
                                    currentStep: 1,
                                  )
                                );
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
                        });
                      }else{
                        Get.snackbar("Failed", "Password tidak sama atau tidak terdapat angka atau huruf besar", backgroundColor: Colors.white, colorText: Colors.black87);
                      }
                    }
                  },
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
}