import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool selected;

  AppTab({this.title, this.onPressed, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: selected ? AppColor.primary : AppColor.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(title,
                style: selected ? AppStyle.title2Primary : AppStyle.title2),
          ),
        ),
      ),
    );
  }
}
