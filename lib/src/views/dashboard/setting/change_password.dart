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
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  AccountsController accountsController = Get.find();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  bool tampilsandipasswordsekarang = true;
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;
  bool hasPasswordSame = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final upperLowerRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');

    setState(() {
      isPasswordEightCharacters = false;
      if (password.length > 7) isPasswordEightCharacters = true;

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) hasPasswordOneNumber = true;
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

   @override
  void initState() {
    super.initState();
    password1.addListener(() {});
    password2.addListener(() {});
  }

  @override
  void dispose() {
    oldPassword.dispose();
    password1.dispose();
    password2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: focusManager,
          child: Scaffold(
            backgroundColor: GlobalVariablesType.backgroundColor,
            appBar: kDefaultAppBarGoBackOnly(context, title: "Change Password"),
            body: SingleChildScrollView(
              padding: GlobalVariablesType.defaultPadding,
              child: Column(
                children: [
                  PasswordTextField(
                    controller: oldPassword,
                    hintText: "input your old password",
                    labelText: "Old Password",
                  ),
                  const SizedBox(height: 10),
                  // PasswordTextField(
                  //   controller: password1,
                  //   hintText: "input your new password",
                  //   labelText: "New Password",
                  // ),
                  // const SizedBox(height: 10),
                  // PasswordTextField(
                  //   controller: password2,
                  //   hintText: "Re-type new password",
                  //   labelText: "Re-type new Password",
                  // ),

                  TextFormField(
                    controller: password1,
                    obscureText: tampilsandipasswordbaru1,
                    keyboardAppearance: Brightness.dark,
                    style: kDefaultTextStyleCustom(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "Set new password",
                      errorStyle: kDefaultTextStyleCustom(color: Colors.red),
                      labelText: "Password",
                      labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
                      hintStyle: TextStyle(color: GlobalVariablesType.mainTextColor.withOpacity(0.7), fontSize: GlobalVariablesType.defaultFontSize),
                      filled: false,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            tampilsandipasswordbaru1 = !tampilsandipasswordbaru1;
                          });
                        },
                        child: tampilsandipasswordbaru1 == true ?  Icon(Icons.visibility, color: GlobalVariablesType.buttonSquereColor![0]) :  Icon(Icons.visibility_off, color: GlobalVariablesType.buttonSquereColor![0]),
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
                  TextFormField(
                    controller: password2,
                    obscureText: tampilsandipasswordbaru2,
                    keyboardAppearance: Brightness.dark,
                    style: kDefaultTextStyleCustom(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      errorStyle: kDefaultTextStyleCustom(color: Colors.red),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: GlobalVariablesType.mainColor),
                      hintStyle: TextStyle(color: GlobalVariablesType.mainTextColor.withOpacity(0.7), fontSize: GlobalVariablesType.defaultFontSize),
                      filled: false,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            tampilsandipasswordbaru2 = !tampilsandipasswordbaru2;
                          });
                        },
                        child: tampilsandipasswordbaru2 == true ?  Icon(Icons.visibility, color: GlobalVariablesType.buttonSquereColor![0]) :  Icon(Icons.visibility_off, color: GlobalVariablesType.buttonSquereColor![0]),
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
                    onChanged: (text) => onPasswordChangeConfirm(password1.text, text),
                  ),
                  
                  const SizedBox(height: 30),
                  SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => kDefaultButtonLogin(
                      title: "Change Password",
                      onPressed: accountsController.isLoading.value == true ? (){} : () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? oldPasswords = prefs.getString('password');
                        if(oldPasswords != null){
                          if(oldPasswords == oldPassword.text){
                            if(hasPasswordSame && hasLowerUpper && hasPasswordOneNumber){
                              if(await accountsController.changePasswordAPI(oldPassword: oldPassword.text, newPassword: password2.text) == true){
                                prefs.setString('password', password2.text);
                                Get.snackbar("Berhasil", "Berhasil merubah kata sandi", backgroundColor: Colors.white, colorText: Colors.black87);
                                Future.delayed(Duration.zero, (){
                                  Navigator.pop(context);
                                });
                              }else{
                                debugPrint("Gagal");
                              }
                            }else{
                              Get.snackbar("Gagal", "Password tidak sama atau tidak terdapat angka atau huruf besar", backgroundColor: Colors.white, colorText: Colors.black87);
                            }
                          }else{
                            Get.snackbar("Gagal", "Password lama tidak valid, mohon ingat kembali", backgroundColor: Colors.white, colorText: Colors.black87);
                          }
                        }else{
                          Get.snackbar("Gagal", "Gagal mendapatkan password", backgroundColor: Colors.white, colorText: Colors.black87);
                        }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                      },
                    ),
                  ),
                ),
                ],
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