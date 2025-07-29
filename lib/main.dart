import 'dart:io';
import 'package:delapanbelasfx/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/views/splash/splashscreen.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

ValueNotifier selectedIndexGlobal = ValueNotifier(0);
late PageController pageController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(debug: false, ignoreSsl: false);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn = 'https://f440ca5ca025b3b3b20f8038f8ff7eba@o4507020870549504.ingest.us.sentry.io/4507020871729152';
  //     options.tracesSampleRate = 1.0;
  //     options.profilesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(const MyApp()),
  // );
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black
      ),
      child: GetMaterialApp(
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
        title: 'TridentPRO Futures',
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cupertinoOverrideTheme: MaterialBasedCupertinoThemeData(materialTheme: ThemeData.dark()),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
          color: GlobalVariablesType.mainColor,
          centerTitle: true,
          elevation: 0,
        ),
          colorScheme: ColorScheme.fromSeed(seedColor: GlobalVariablesType.buttonTextColor![1]),
          useMaterial3: false,
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}
