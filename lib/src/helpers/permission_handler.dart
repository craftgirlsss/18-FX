import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

permissionServiceCall(BuildContext context) async {  
  final permissionStatusStorage = await Permission.storage.status;
  if (permissionStatusStorage.isDenied) {
      await Permission.storage.request();
  } else if (permissionStatusStorage.isPermanentlyDenied) {
      await openAppSettings();
  } else {
    print(permissionStatusStorage);
  }
  
  final permissionStatusCamera = await Permission.camera.status;
  if (permissionStatusCamera.isDenied) {
      await Permission.camera.request();
  } else if (permissionStatusCamera.isPermanentlyDenied) {
      await openAppSettings();
  } else {
    print(permissionStatusCamera);
  }

  final permissionStatusPhotos = await Permission.photos.status;
  if (permissionStatusPhotos.isDenied) {
      await Permission.photos.request();
  } else if (permissionStatusPhotos.isPermanentlyDenied) {
      await openAppSettings();
  } else {
    print(permissionStatusPhotos);
  }
}
