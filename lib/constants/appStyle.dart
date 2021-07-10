import 'package:demo_b/constants/appColor.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle h1 = TextStyle(
      fontSize: 22, color: AppColor.black, fontWeight: FontWeight.bold);
  static const TextStyle h2 = TextStyle(
      fontSize: 20, color: AppColor.black, fontWeight: FontWeight.bold);
  static const TextStyle h3 = TextStyle(
      fontSize: 18, color: AppColor.black, fontWeight: FontWeight.bold);
  static const TextStyle h4 = TextStyle(
      fontSize: 16, color: AppColor.black, fontWeight: FontWeight.bold);

  static const TextStyle h0White =
      TextStyle(fontSize: 30, color: AppColor.white);
  static const TextStyle h1White = TextStyle(
      fontSize: 22, color: AppColor.white, fontWeight: FontWeight.bold);
  static const TextStyle h2White = TextStyle(
      fontSize: 20, color: AppColor.white, fontWeight: FontWeight.bold);
  static const TextStyle h3White = TextStyle(
      fontSize: 18, color: AppColor.white, fontWeight: FontWeight.bold);
  static const TextStyle h4White = TextStyle(
      fontSize: 16, color: AppColor.white, fontWeight: FontWeight.bold);

  static const TextStyle title1 =
      TextStyle(fontSize: 18, color: AppColor.black);
  static const TextStyle title1White =
      TextStyle(fontSize: 18, color: AppColor.white);
  static const TextStyle title1Primary =
      TextStyle(fontSize: 18, color: AppColor.primary);

  static const TextStyle title2 =
      TextStyle(fontSize: 16, color: AppColor.black);
  static const TextStyle title2White =
      TextStyle(fontSize: 16, color: AppColor.white);
  static const TextStyle title2Grey =
      TextStyle(fontSize: 16, color: AppColor.grey);
  static const TextStyle title2Primary =
      TextStyle(fontSize: 16, color: AppColor.primary);

  static const TextStyle subtitle1 =
      TextStyle(fontSize: 14, color: AppColor.black);
  static const TextStyle subtitle2 =
      TextStyle(fontSize: 12, color: AppColor.black);
  static const TextStyle subtitle1Grey =
      TextStyle(fontSize: 14, color: AppColor.grey);

  static const TextStyle content =
      TextStyle(fontSize: 16, color: AppColor.black);
  static const TextStyle contentWhite =
      TextStyle(fontSize: 16, color: AppColor.white);
  static const TextStyle contentPrimary =
      TextStyle(fontSize: 16, color: AppColor.primary);
}
