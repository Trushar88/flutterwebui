import 'package:flutter/material.dart';
import 'package:flutterwebtest/App/Constant/color_const.dart';
import 'package:image_network/image_network.dart';

class CommonImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color? backgroundColor;
  final double? radius;
  final BoxFit? boxFit;
  final VoidCallback? onImageTapped;
  const CommonImageWidget({super.key, required this.imageUrl, required this.width, required this.height, this.backgroundColor, this.radius, this.boxFit, this.onImageTapped});

  @override
  Widget build(BuildContext context) {
    return ImageNetwork(
        image: imageUrl,
        height: height,
        width: width,
        curve: Curves.easeIn,
        onPointer: true,
        debugPrint: false,
        fullScreen: false,
        fitAndroidIos: boxFit ?? BoxFit.cover,
        fitWeb: BoxFitWeb.cover,
        onLoading: const CircularProgressIndicator(
          color: Colors.indigoAccent,
        ),
        onError: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: backgroundColor ?? AppColor.lightGray),
          child: Center(
            child: Icon(
              Icons.error,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(radius ?? 10),
        onTap: onImageTapped ?? () {});
  }
}
