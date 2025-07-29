import 'package:delapanbelasfx/src/components/alerts.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/buttons.dart';
import 'package:delapanbelasfx/src/components/loadings.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/components/textfields.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:delapanbelasfx/src/views/login/forgot.dart';
import 'package:delapanbelasfx/src/views/login/otp.dart';
import 'package:delapanbelasfx/src/views/login/rejected_page.dart';
import 'package:delapanbelasfx/src/views/mainpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view_stepper_trial.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId: '614768399153-f82ljd59mobsjdd3n9v5l2ra7mm5osd4.apps.googleusercontent.com',
  scopes: scopes,
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountsController accountsController = Get.find();
  TextEditingController emailContrller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailContrller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        PopScope(
          canPop: false,
          child: GestureDetector(
            onTap: () {
              focusManager();
              if(kDebugMode) print(accountsController.emailTemp.value);
            },
            child: Scaffold(
              extendBodyBehindAppBar: false,
              backgroundColor: GlobalVariablesType.backgroundColor,
              appBar: kDefaultAppBarCustom(context, actions: [
              CupertinoButton(child: const Icon(CupertinoIcons.info, color: GlobalVariablesType.mainColor), onPressed: (){
                alertDialogCustomInfo(
                  title: "Informasi",
                  message: "Penuhi semua field terlebih dahulu untuk dapat menggunakan aplikasi TridentPro Futures",
                  onTap: (){
                    Navigator.pop(context);
                  }
                );
              })
            ],
            title: const Text("Masuk", style: TextStyle(color: GlobalVariablesType.mainColor))
            ),
              body: SafeArea(
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_launcher.png', width: size.width / 2),
                        const Text("Masuk", style: TextStyle(color: GlobalVariablesType.mainColor, fontWeight: FontWeight.bold, fontSize: 25)),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: size.width / 1.5,
                          child: const Text("Raih peluang investasi dengan bergabung bersama TridentPRO Futures", style: TextStyle(color: GlobalVariablesType.mainColor), textAlign: TextAlign.center,)),
                      ],
                    ),
                    const SizedBox(height: 15),
                      EmailTextField(
                        hintText: "Input your email",
                        labelText: "Email",
                        controller: emailContrller,
                      ),
                      const SizedBox(height: 15),
                      PasswordTextField(
                        controller: passwordController,
                        hintText: "input your password",
                        labelText: "Password",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Container(
                          //   color: Colors.transparent,
                          //   child: Row(
                          //     children: [
                          //       CupertinoCheckbox(
                          //         activeColor: GlobalVariablesType.mainColor,
                          //         value: isChecked, 
                          //         onChanged: (bool? value){
                          //           setState(() {
                          //             isChecked = value!;
                          //           });
                          //         }),
                          //         Text(GlobalVariablesType.rememberMeText!, style: kDefaultTextStyleButtonText(color: GlobalVariablesType.mainColor),)
                          //     ],
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: (){
                              Get.to(() => const ForgotPassword());
                            },
                            child: Text(GlobalVariablesType.forgotText, style: kDefaultTextStyleButtonText(color: GlobalVariablesType.mainColor, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.width,
                          child: Obx(
                            () =>  kDefaultButtonLogin(
                              onPressed: accountsController.isLoading.value ? (){} : () {
                                focusManager();
                                if(formKey.currentState!.validate()){
                                  accountsController.login(email: emailContrller.text, password: passwordController.text).then((result) async {
                                    if(result){
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      var personalDetail = accountsController.detailTempModel.value?.response.personalDetail;
                                      prefs.setString('email', personalDetail!.email!);
                                      prefs.setString('password', passwordController.text);
                                      switch (personalDetail.status) {
                                        case "-1":
                                          Get.offAll(() => const MainPage());
                                          break;
                                        case "0":
                                          Get.to(() => OTPPage(phone: personalDetail.phone, email: personalDetail.email, normalyRegisteredProcess: false, name: personalDetail.name));
                                          break;
                                        case "1":
                                          Get.to(() => const RejectedPage());
                                          break;
                                        case "2":
                                          Get.to(() => StepperTrialPage(
                                            email: personalDetail.email,
                                            name: personalDetail.name,
                                            normalyRegisteredProcess: false,
                                            phone: personalDetail.phone,
                                            fromLogin: true,
                                            registerWithGoogle: false,
                                            loginWithGoogle: false,
                                            currentStep: personalDetail.ver != null ? int.parse(accountsController.detailTempModel.value!.response.personalDetail.ver!) : 1,
                                          ));
                                          break;
                                        default:
                                          alertError(
                                            title: "Error",
                                            message: accountsController.responseMessage.value,
                                            onTap: (){Navigator.pop(context);}
                                          );
                                      }
                                    }else{
                                      alertError(
                                        title: "Galat",
                                        message: accountsController.responseMessage.value,
                                        onTap: (){ Navigator.pop(context);}
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Center(
                      //   child: Text("Atau masuk dengan", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor, fontWeight: FontWeight.normal, fontSize: 14),)
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Obx(
                      //     () => kDefaultButtonLoginWithGoogle(
                      //       backgroundColor: Colors.white,
                      //       onPressed: accountsController.isLoading.value ? (){} : () async {
                      //         await googleSignIn.signOut();
                      //         accountsController.signInWithGoogle();
                      //         GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                      //         GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                      //         AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
                      //         UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                      //         User? user = userCredential.user;
                      //         accountsController.loginWithGoogleMethod(email: user?.email, name: user?.displayName, imageProfile: user?.displayName).then((result) async {
                      //           if(result){
                      //             var personalDetail = accountsController.detailTempModel.value?.response.personalDetail;
                      //             if(personalDetail?.status == "2"){
                      //               Get.to(() => StepperTrialPage(
                      //                 email: personalDetail?.email,
                      //                 name: personalDetail?.name,
                      //                 normalyRegisteredProcess: false,
                      //                 fromLogin: true,
                      //                 registerWithGoogle: true,
                      //                 loginWithGoogle: false,
                      //                 currentStep: personalDetail?.ver != null ? int.parse(accountsController.detailTempModel.value!.response.personalDetail.ver!) : 1,
                      //               ));
                      //             }else if(personalDetail?.status == "-1"){
                      //               SharedPreferences prefs = await SharedPreferences.getInstance();
                      //               prefs.setString('email', personalDetail!.email!);
                      //               Get.offAll(() => const MainPage());
                      //             }else{
                      //               alertError(
                      //                 title: "Galat",
                      //                 message: "Status tidak ditemukan",
                      //                 onTap: (){ Navigator.pop(context);}
                      //               );
                      //             }
                      //           }else{
                      //             alertError(
                      //               title: "Galat",
                      //               message: accountsController.responseMessage.value,
                      //               onTap: (){ Navigator.pop(context);}
                      //             );
                      //           }
                      //         });
                      //       } ,
                      //       title: "Sign in with Google"
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   child: SizedBox(
                      //     width: size.width,
                      //     child: Obx(() => OutlinedButton(
                      //       style: OutlinedButton.styleFrom(
                      //         side: BorderSide(width: 1, color: GlobalVariablesType.mainColor),
                      //       ),
                      //         onPressed: accountsController.isLoading.value ? null : (){
                      //           accountsController.skipToDashboard.value = true;
                      //           Get.to(() => const MainPage());
                      //         },
                      //         child: Text("Skip to Dashboard", style: kDefaultTextStyleCustom(color: GlobalVariablesType.mainColor, fontWeight: FontWeight.bold, fontSize: 14),),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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
}