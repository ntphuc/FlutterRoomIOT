import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    @required this.title,
    this.onPressed,
    this.contained = false,
    this.full = false,
    this.primary = false,
  });

  final String title;
  final Function() onPressed;
  final bool contained;
  final bool full;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    if (contained) {
      return Container(
        width: full ? ScreenUtil.width : null,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            '$title',
            style: AppStyle.title1White,
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  primary ? AppColor.primary : AppColor.grey),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ))),
        ),
      );
    }
    return TextButton(
      child: Text(
        '$title',
        style: primary ? AppStyle.title2Primary : AppStyle.title2,
      ),
      onPressed: onPressed,
    );
  }
}
