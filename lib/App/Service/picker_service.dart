import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterwebtest/App/Constant/color_const.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PickerService {
  final _picker = ImagePicker();

  Future<File?> pickImage(ImageSource imageSource, bool isCrop) async {
    try {
      XFile? tempImage = await _picker.pickImage(source: imageSource);

      if (tempImage != null) {
        if (isCrop) {
          final File? croppedFile = await cropImage(File(tempImage.path));
          if (croppedFile != null) {
            return croppedFile;
          } else {
            return File(tempImage.path);
          }
        } else {
          return File(tempImage.path);
        }
      } else {
        return null;
      }
    } catch (err) {
      log("PickerService-pickImage $err");
      return null;
    }
  }

  Future<File?> cropImage(File imageFile) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
        uiSettings: [
          AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: AppColor.blackColor, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        return null;
      }
    } catch (err) {
      log("PickerService-cropImage $err");
      return null;
    }
  }

  Future<File?> pickVideo(ImageSource imageSource) async {
    try {
      XFile? tempVideo = await _picker.pickVideo(source: imageSource);

      if (tempVideo != null) {
        return File(tempVideo.path);
      } else {
        return null;
      }
    } catch (err) {
      log("PickerService -pickVideo  $err");
      return null;
    }
  }

  Future<File?> getThumbnailFromFile(String path) async {
    try {
      final filePath = await VideoThumbnail.thumbnailFile(
        video: path,
        imageFormat: ImageFormat.JPEG,
        thumbnailPath: (await getTemporaryDirectory()).path,
        maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );
      if (filePath != null) {
        return File(filePath);
      } else {
        return null;
      }
    } catch (err) {
      log("PickerService -getThumbnailFromFile  $err");
      return null;
    }
  }
}
