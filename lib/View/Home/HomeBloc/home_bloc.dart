// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebtest/App/Base/base_model.dart';
import 'package:flutterwebtest/App/Common/common_button_widget.dart';
import 'package:flutterwebtest/App/Constant/color_const.dart';
import 'package:flutterwebtest/App/Extensions/uicontext.dart';
import 'package:flutterwebtest/App/Service/picker_service.dart';
import 'package:flutterwebtest/Models/category_model.dart';
import 'package:flutterwebtest/View/Home/HomeBloc/home_state.dart';
import 'package:flutterwebtest/View/Home/home_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vector_math/vector_math.dart' as matht;

import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with BaseModel {
  HomeBloc() : super(HomeInitial()) {
    on<HomeAddImageButtonClickEvent>(homeAddImageButtonClickEvent);
    on<HomeInitEvent>(homeInitEvent);

    on<HomeUploadClick>(uploadImageDialog);
  }
  late BuildContext context;

  final nameController = TextEditingController();

  final imageName = TextEditingController();

  CategoryModel? selectCategory;

  File? selectedImage;

  List<CategoryModel> categoryList = [];
  final _formGlobalKey = GlobalKey<FormState>();

  FutureOr<void> homeAddImageButtonClickEvent(HomeAddImageButtonClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToImageAddState('https://fastly.picsum.photos/id/533/200/300.jpg?hmac=eehg5zb3wyJViBC8IiDL85fqqk9z85uHtRciYvDovgA'));
  }

  FutureOr<void> homeInitEvent(HomeInitEvent event, Emitter<HomeState> emit) async {
    // await Future.delayed(const Duration(seconds: 4));
    // emit(HomeLoaded());
    // await Future.delayed(const Duration(seconds: 4));
    // emit(HomeError());
    // await Future.delayed(const Duration(seconds: 4));
    List list = await getCategories();

    emit(HomeLoaded(list as List<CategoryModel>));
  }

  Future<List> getCategories() async {
    try {
      showLoader(context);
      List<CategoryModel> categories = await HomeRepo().getCategories();
      categoryList = categories;
      hideLoader(context);
      return categories;
    } catch (err) {
      hideLoader(context);
      errorLog("HomeBloc", "getCategories", err.toString());
      return [];
    }
  }

  Future addCategory() async {
    try {
      if (_formGlobalKey.currentState!.validate()) {
        Navigator.of(context).pop();

        showLoader(context);

        bool value = await HomeRepo().addCategory(CategoryModel(id: categoryList.length + 1, isActive: true, name: nameController.text.trim()));

        hideLoader(context);
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category submitted successfully")));
          add(HomeInitEvent());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
        }
      }
    } catch (err) {
      hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));

      errorLog("HomeBloc", "getCategories", err.toString());
      return [];
    }
  }

  FutureOr<void> uploadImageDialog(HomeUploadClick event, Emitter<HomeState> emit) async {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return const SizedBox();
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        barrierLabel: '',
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.rotate(
            angle: matht.radians(anim1.value * 360),
            child: AlertDialog(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              contentPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                height: 70,
                child: Center(
                    child: Text(
                  'Choose your option....',
                  style: context.customRegular(AppColor.whiteColor, 16),
                )),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        uploadCategoryFrom();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(border: Border.all(color: AppColor.blackColor), borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            "Insert Category",
                            style: context.customRegular(AppColor.blackColor, 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        uploadImage();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(border: Border.all(color: AppColor.blackColor), borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            "Upload Photo",
                            style: context.customRegular(AppColor.blackColor, 16),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 45,
                    //   decoration: BoxDecoration(border: Border.all(color: AppColor.blackColor), borderRadius: BorderRadius.circular(15)),
                    //   child: Center(
                    //     child: Text(
                    //       "Upload Video",
                    //       style: context.customRegular(AppColor.blackColor, 16),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

  Future uploadCategoryFrom() async {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return const SizedBox();
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        barrierLabel: '',
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.rotate(
            angle: matht.radians(anim1.value * 360),
            child: AlertDialog(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              contentPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                height: 70,
                child: Center(
                    child: Text(
                  'Insert Category',
                  style: context.customRegular(AppColor.whiteColor, 16),
                )),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (c) {
                          if (c!.isEmpty) {
                            return "Please enter category name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Name"),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // DropdownButtonFormField(
                      //   hint: const Text("Select category"),
                      //   items: categoryList.map((CategoryModel category) {
                      //     return DropdownMenuItem(value: category, child: Text(category.name.toString()));
                      //   }).toList(),
                      //   onChanged: (newValue) {
                      //     // do other stuff with _category
                      //     selectCategory = newValue;
                      //   },
                      //   value: selectCategory,
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      BouncingButton(
                        onPress: () async {
                          await addCategory();
                        },
                        textColor: Colors.white,
                        hoverTextColor: Colors.cyanAccent,
                        text: "Submit",
                        radiusColor: Colors.cyanAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

  Future uploadImage() async {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return const SizedBox();
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        barrierLabel: '',
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.rotate(
            angle: matht.radians(anim1.value * 360),
            child: AlertDialog(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              contentPadding: const EdgeInsets.all(0),
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                height: 70,
                child: Center(
                    child: Text(
                  'Upload Image',
                  style: context.customRegular(AppColor.whiteColor, 16),
                )),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (c) {
                          if (c!.isEmpty) {
                            return "Please enter image name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Image Name"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        hint: const Text("Select Image category"),
                        items: categoryList.map((CategoryModel category) {
                          return DropdownMenuItem(value: category, child: Text(category.name.toString()));
                        }).toList(),
                        onChanged: (newValue) {
                          // do other stuff with _category
                          selectCategory = newValue;
                        },
                        value: selectCategory,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickImageFrom(ImageSource.gallery, context);
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColor.blackColor),
                            image: selectedImage != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      selectedImage!.path,
                                    ))
                                : null,
                          ),
                          child: Center(
                            child: selectedImage == null
                                ? Text(
                                    "Select Image",
                                    style: context.customRegular(AppColor.blackColor, 16),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BouncingButton(
                        onPress: () async {},
                        textColor: Colors.white,
                        hoverTextColor: Colors.cyanAccent,
                        text: "Submit",
                        radiusColor: Colors.cyanAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

  Future uploadImageToFB() async {
    try {
      if (_formGlobalKey.currentState!.validate()) {
        Navigator.of(context).pop();

        showLoader(context);

        bool value = await HomeRepo().addCategory(CategoryModel(id: categoryList.length + 1, isActive: true, name: nameController.text.trim()));

        hideLoader(context);
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category submitted successfully")));
          add(HomeInitEvent());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
        }
      }
    } catch (err) {
      hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));

      errorLog("HomeBloc", "uploadImageToFB", err.toString());
      return [];
    }
  }

  Future _pickImageFrom(ImageSource imageSource, context) async {
    try {
      selectedImage = await PickerService().pickImage(imageSource, true);
      Navigator.of(context).pop();
      uploadImage();
    } catch (err) {
      errorLog("", "_pickImageFrom", err.toString());
    }
  }

  Future _pickVideoFrom(ImageSource imageSource, context) async {
    try {
      File? selectedVideo = await PickerService().pickVideo(imageSource);
      if (selectedVideo != null) {
        File? thmbNail = await PickerService().getThumbnailFromFile(selectedVideo.path);
      }
    } catch (err) {
      errorLog("", "_pickVideoFrom", err.toString());
    }
  }
}
