import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';

class ConnectivyService {
  static final ConnectivyService _instance = ConnectivyService._();

  ConnectivyService._();

  factory ConnectivyService() {
    return _instance;
  }

  static final Connectivity _connectivity = Connectivity();

  static final AppStream<bool> connection = AppStream<bool>.seeded(false);

  static Future<void> init() async {
    connection.add(await getConnectiviy);
    _connectivity.onConnectivityChanged
        .listen((event) => connection.add(event != ConnectivityResult.none));
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (connection.value) return;
      try {
        final result = await InternetAddress.lookup('www.kindacode.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          connection.add(true);
        }
      } on SocketException catch (_) {
        connection.add(false);
      }
    });
  }

  static Future<bool> get getConnectiviy async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
