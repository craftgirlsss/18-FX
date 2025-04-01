import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/accounts_controller.dart';

import '../../login/register_v2.dart';
class MarketsWebView extends StatefulWidget {
  const MarketsWebView({super.key});

  @override
  State<MarketsWebView> createState() => _MarketsWebViewState(); }

class _MarketsWebViewState extends State<MarketsWebView> with AutomaticKeepAliveClientMixin<MarketsWebView>{
  AccountsController accountsController = Get.find();
  bool noInternet = false;
  Timer? timer;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  InAppWebViewController? webViewController;
  double progress = 0;
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => webViewController?.reload());
    initConnectivity();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    super.build(context);
    return Obx(
      () => accountsController.skipToDashboard.value ?
        Container(
          width: size.width,
          height: size.height,
          color: GlobalVariablesType.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("You are not logged in, please log in first to be able to use all available features.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width / 2,
                child: ElevatedButton(onPressed: (){
                  Get.back();
                }, child: const Text("Login")),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: size.width / 2,
                child: ElevatedButton(onPressed: (){
                  Get.back();
                  Get.to(() => const RegisterAccountV2());
                }, child: const Text("Register")),
              ),
            ],
          ),
        ) : Scaffold(
        backgroundColor: GlobalVariablesType.backgroundColor,
        appBar: appBarHomePage(context, webViewController: webViewController),
        body: Stack(
          children: [
            noInternet ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.wifi_slash, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Tidak ada koneksi internet", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                )
                ],
              ),
            ) :
            Column(children: <Widget>[
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri("https://m.dbsolution.app/home.php?page=market&id=${accountsController.userID}")),
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  },
                  onReceivedError: (controller, request, error) {
                    controller = webViewController!;
                    // setState(() {
                    //   controller.reload();
                    // });
                    print(request.headers);
                  },
                  onReceivedHttpError: (controller, request, errorResponse) {
                    controller = webViewController!;
                    // setState(() {
                    //   controller.reload();
                    // });
                  },
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                    setState(() {
                      progress = 100;
                    });
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      showLoading = false;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      setState(() {
                        showLoading = false;
                      });
                    }else{
                        setState(() {
                        showLoading = true;
                      });
                    }
                  },
                ),
              )
            ]),
            showLoading ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: const Center(child: CupertinoActivityIndicator())) : const SizedBox()
          ],
        ),
      ),
    );
  }
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status $e');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    if(_connectionStatus[0] == ConnectivityResult.none){
      noInternet = true;
    }else{
      webViewController?.reload();
      noInternet = false;
    }
    debugPrint('Connectivity changed: $_connectionStatus');
  }
  
  @override
  bool get wantKeepAlive => true; 
}