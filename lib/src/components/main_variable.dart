import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalVariablesType extends StatelessWidget{
  const GlobalVariablesType({super.key});
  
  // url untuk mengarahkan webview
  static String? urlWeb = "https://18fx.co.id";

  // url terms & conditions
  static String termsAndConditions = "https://18fx.co.id/about-us";

  // terms and condition text
  static String termsAndConditionsText = "Tentang Kami";

  // String nama aplikasi
  static String? nameApp = "App Name";

  // ucapan selamat datang untuk login
  static String ucapanLogin = "Selamat datang";

  // ucapan selamat datang untuk login
  static String showProfile = "Tampilkan Profil";

  // ucapan profilku
  static String profileku = "Account Details";

  // ucapan selamat datang untuk login
  static String ucapanSignUP = "Selesaikan Registrasi";

  // judul di page splash screen
  static String? titleSplashScreen = "Log in to your account";

  // deskripsi di page splashscreen
  static String? descriptionSplashScreen = "Jadikan setiap peluang menguntungkan bersama 18FX";

  // Teks Login
  static String? loginText = "MASUK";

  // Teks Submit
  static String? submitText = "KONFIRMASI";

  // Teks SignUp
  static String? signUpText = "DAFTAR";

  // Teks lupa password
  static String? forgotText = "Lupa Akun?";

  // Teks lupa password
  static String? rememberMeText = "Tetap Login";

  // Teks agreement
  static String? agreeText = "Saya setuju";

  // Teks buat akun
  static String? buatAkunText = "Tidak punya akun? Buat Akun";

  static Color mainColor = const Color.fromRGBO(255,215,0, 1);

  static var gradientColor = [
    mainColor.withOpacity(0.5),
    mainColor.withOpacity(0.7),
    mainColor.withOpacity(0.9),
    mainColor,
  ];

  static Color mainTextColor = Colors.white;

  static double defaultFontSize = 11;

  // main color button semua screen
  static List<Color>? buttonSquereColor = [
    Colors.orange.withOpacity(0.9),
    Colors.blue.shade400,
  ];

  // Elevation
  static double? elevation = 0;

  // Font Family
  static String fontFamily = "Inter";
  static String fontFamilyBold = "Inter-ExtraBold";
  // fontSize
  static double fontSizeTitleSmall12 = 12;
  static double fontSizeTitleMedium14 = 14;
  static double fontSizeTitleBig17 = 16;
  static double fontSizeTitleBig27 = 27;
 
  // main color text button semua screen
  static List<Color>? buttonTextColor = [
    Colors.black54,
    CupertinoColors.activeBlue,
    Colors.white,
    Colors.orange.shade400,
  ];

  // main color text borderLineTextField semua screen
  static List<Color>? borderLineTextFieldColor = [
    Colors.orange.shade400,
    CupertinoColors.activeBlue,
  ];
  
  // BackgroundColor all page
  static Color? backgroundColor = Colors.black;
  
  // Color of text black
  static List<Color?> colorTextBlack = [
    Colors.white,
    Colors.black54,
    Colors.black38
  ];
  // AutoImplyLeading
  static bool autoImplyLeadingAppBarFalse = false;
  static bool autoImplyLeadingAppBarTrue = true;

  // padding page
  static double paddingLeft = 20;
  static double paddingRight = 20;
  static double paddingTop = 15;
  static double paddingBottom = 0;
  static EdgeInsets? defaultPadding = const EdgeInsets.only(left: 15, right: 15);

  // Spacing sizedbox
  static double height = 5;
  static double width = 5;
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
