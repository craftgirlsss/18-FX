import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({super.key, this.pathImage});
  final String? pathImage;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Viewer"),
      ),
      body: pathImage == null ? SizedBox(
        width: size.width,
        height: size.height,
        child: const Center(
          child: Column(
            children: [
              Icon(Clarity.image_gallery_line, color: Colors.white60, size: 40),
              SizedBox(height: 10),
              Text("Gagal mendapatkan gambar", style: TextStyle(color: Colors.white60),),
            ],
          ),
        ),
      ) : PhotoView(
        imageProvider: FileImage(File(pathImage!)),
        errorBuilder: (context, error, stackTrace) => const Text("Gagal mendapatkan gambar", style: TextStyle(color: Colors.black),),
      )
    );
  }
}