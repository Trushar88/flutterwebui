import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterwebtest/App/Base/base_model.dart';
import 'package:flutterwebtest/App/Constant/api_const.dart';
import 'package:flutterwebtest/Models/category_model.dart';

class HomeRepo with BaseModel {
  Future getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore.instance.collection(ApiConst.categoryCollection).get();
      if (response.docs.isNotEmpty) {
        return response.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
      } else {
        return [];
      }
    } catch (err) {
      errorLog("HomeRepo", "getCategories", err.toString());
      return [];
    }
  }

  Future addCategory(CategoryModel category) async {
    try {
      await FirebaseFirestore.instance.collection(ApiConst.categoryCollection).add(category.toJson());
      return true;
    } catch (err) {
      errorLog("HomeRepo", "addCategory", err.toString());
      return false;
    }
  }

  Future<bool> addImage() async {
    try {
      await FirebaseFirestore.instance.collection(ApiConst.imageCollection).add({});
      return true;
    } catch (err) {
      errorLog("HomeRepo", "addCategory", err.toString());
      return false;
    }
  }

  Future<String> imageUpload(File imageFile) async {
    try {
      String downloadUrl = "";
      Reference reference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      await reference
          .putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await reference.getDownloadURL().then((value) {
          downloadUrl = value;
        });
      });
      return downloadUrl;
    } catch (err) {
      errorLog("HomeRepo", "imageUpload", err.toString());
      return "";
    }
  }
}
