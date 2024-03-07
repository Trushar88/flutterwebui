// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwebtest/App/Service/network_service.dart';
import 'package:loader_overlay/loader_overlay.dart';

mixin BaseModel {
  //loader value (true = showloader)
  bool loaderValue = false;

  //print error log (only debug mode)
  errorLog(String screenName, String methodName, String err) {
    log("Exception - $methodName in $screenName :- $err ");
  }

  Future<bool> checkNetwork(context) async {
    await NetworkController().checkNetworkOnce();
    if (NetworkController().connectionStatus != 0) {
      return true;
    } else {
      return false;
    }
  }

  hideLoader(BuildContext context) {
    try {
      if (context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    } catch (err) {
      errorLog("BaseModel", "hideLoader", err.toString());
    }
  }

  showLoader(BuildContext context) => context.loaderOverlay.show();
}
