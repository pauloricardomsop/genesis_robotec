import 'package:genesis_robotec/app/core/components/loading.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showLoadingDialog(_) {
    showDialog(
      context: _,
      barrierDismissible: false,
      builder: (_) {
        FocusManager.instance.primaryFocus!.unfocus();
        return const Loading();
      },
    );
  }
}
