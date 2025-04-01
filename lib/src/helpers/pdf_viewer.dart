import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/textstyle.dart';
import 'package:delapanbelasfx/src/helpers/url_launchers.dart';
import 'package:share_plus/share_plus.dart';

class PDFViewersPage extends StatefulWidget {
  final String? urlPath;
  const PDFViewersPage({super.key, this.urlPath});

  @override
  State<PDFViewersPage> createState() => _PDFViewersPageState();
}

class _PDFViewersPageState extends State<PDFViewersPage> with WidgetsBindingObserver{
  final Completer<PDFViewController> controllerPDF = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kDefaultAppBarCustom(
        context,
        autoImplyLeading: true,
        title: Text("PDF Viewer", style: kDefaultTextStyleTitleAppBar(fontSize: 17)),
        actions: [
          IconButton(
            onPressed: () async {
            final result = await Share.shareXFiles([XFile('${widget.urlPath}')], text: 'GIFX Documents');
            if (result.status == ShareResultStatus.success) {
                print('Thank you for sharing the picture!');
            }
            },
          icon: const Icon(CupertinoIcons.share))
        ]
      ),
      body: PDFView(
        filePath: widget.urlPath,
        enableSwipe: true,
        nightMode: false,
        onLinkHandler: (uri) => launchUrls(uri ?? 'https://gifx.co.id'),
        autoSpacing: false,
        pageFling: false,
        onRender: (pagess) {
          setState(() {
            pages = pagess;
            isReady = true;
          });
        },
        onError: (error) {
          setState(() {
            errorMessage = error.toString();
          });
          print(error.toString());
        },
        onPageError: (page, error) {
          setState(() {
            errorMessage = '$page: ${error.toString()}';
          });
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          controllerPDF.complete(pdfViewController);
        },
      ),
    );
  }
}