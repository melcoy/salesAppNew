import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class Connection {
  String _connectionStatus = "";
  final Connectivity _connectivity = Connectivity();

  //StreamSubscription<ConnectivityResult> _connectionSubscription;

  Future<bool> initConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      connectionStatus = "Internet connectivity failed";
    }

    _connectionStatus = connectionStatus;

    if (_connectionStatus == "ConnectivityResult.mobile" ||
        _connectionStatus == "ConnectivityResult.wifi") {
      return true;
    } else {
      return false;
    }
  }
}
