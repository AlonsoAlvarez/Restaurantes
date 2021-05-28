import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Images {
  static Future<File> pickedFile(ImageSource source) async {
    PickedFile? pickedFile =
        await ImagePicker().getImage(source: source);
    return File(pickedFile!.path);
  }

  static Future<File> pickedVideo(source) async {
    PickedFile? pickedFile =
        await ImagePicker().getVideo(source: source);
    return File(pickedFile!.path);
  }

  static Future<File> cropImage(File foto) async {
    File? cropped = await ImageCropper.cropImage(
        sourcePath: foto.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cortar',
        ));
    return foto = cropped ?? foto;
  }
}
