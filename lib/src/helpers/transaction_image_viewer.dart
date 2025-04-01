import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String urlImage;
  const ImageViewer({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text("Image Preview"),
        previousPageTitle: "Deposit",
      ),
      child: Container(
          color: Colors.transparent,
          child: PhotoView(
            imageProvider: FileImage(File(urlImage)),
            errorBuilder: (context, error, stackTrace) => const Text("Gagal mendapatkan gambar", style: TextStyle(color: Colors.black),),
          )
      ),
    );
  }
}


class ImageViewerOnline extends StatelessWidget {
  final String urlImage;
  final String? previousText;
  const ImageViewerOnline({super.key, required this.urlImage, this.previousText});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: const Text("Image Preview"),
        previousPageTitle: previousText ?? "Deposit",
      ),
      child: Container(
          color: Colors.transparent,
          child: PhotoView(
            imageProvider: NetworkImage(urlImage),
            errorBuilder: (context, error, stackTrace) => const Center(child: DefaultTextStyle(style: TextStyle(color: Colors.black), child: Text("Gagal mendapatkan gambar"))),
          )
      ),
    );
  }
}