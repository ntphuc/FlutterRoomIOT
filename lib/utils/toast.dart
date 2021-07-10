import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

enum ToastType { Success, Warning, Failure }

class Toast {
  static void success({@required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        backgroundColor: AppColor.success,
        position: ToastPosition.bottom,
        textStyle: AppStyle.contentWhite,
        textPadding: const EdgeInsets.all(8.0));
  }

  static void error({@required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        backgroundColor: AppColor.error,
        position: ToastPosition.bottom,
        textStyle: AppStyle.contentWhite,
        textPadding: const EdgeInsets.all(8.0));
  }

  static void warn({@required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        backgroundColor: AppColor.warn,
        position: ToastPosition.bottom,
        textStyle: AppStyle.contentWhite,
        textPadding: const EdgeInsets.all(8.0));
  }
}
