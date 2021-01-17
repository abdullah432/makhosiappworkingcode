import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class AppToast {
  static showToast({@required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.COLOR_PRIMARY,
      textColor: AppColors.COLOR_WHITE,
      fontSize: 16.0,
    );
  }
}
