// ignore_for_file: file_names, unused_field, missing_return, body_might_complete_normally_nullable

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController {
  dynamic a;
  dynamic o;

  var connectionStatus = 0;

  static final Connectivity _connectivity = Connectivity();

  Future<bool> checkNetworkOnce() async {
    dynamic result = await _connectivity.checkConnectivity();
    dynamic checkInitResult = updateConnectivity(result);
    try {
      if (checkInitResult == 0) {
        return false;
      } else {
        return true;
        // final result = await InternetAddress.lookup('google.com');
        // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //   return true;
        // } else {
        //   return false;
        // }
      }
    } on SocketException catch (_) {
      log("Not Connected Exception........");
      return false;
    }
  }

  Future<bool> checkNetwork() async {
    bool? resultNetwork = false;
    try {
      if (connectionStatus != 0) {
        try {
          final result = await InternetAddress.lookup('google.com'); // if device is connectd then check internet is working or not
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            resultNetwork = true; // if internet running then send status true
          } else {
            // showSnackBar("Network error", "Please check your internet connection", 2);
          }
        } on SocketException catch (_) {
          resultNetwork = false;
          // showSnackBar("Network error", "Please check your internet connection", 2);
        }
      } else {
        // showSnackBar("Network error", "Please check your internet connection", 2);
        resultNetwork = false;
      }
      return resultNetwork;
    } catch (e) {
      log("Excpetion - EventController.dart -  checkBody():$e");
      return false;
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      log(e.toString());
    }
    return updateConnectivity(result);
  }

  updateConnectivity(ConnectivityResult? result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus = 1; // if connected with wifi status set 1
        break;
      case ConnectivityResult.mobile:
        connectionStatus = 2; // if connected with wifi status set 2
        break;
      case ConnectivityResult.none:
        connectionStatus = 0; // if not connected with wifi or mobile status set 0
        break;
      default:
    }
  }
}
