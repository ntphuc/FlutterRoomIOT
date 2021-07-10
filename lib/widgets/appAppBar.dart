import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String title;
  final bool allowBack;
  final Widget leading;
  final List<Widget> actions;
  final Color backgroundColor;

  AppAppBar(
      {this.centerTitle = false,
      this.title,
      this.allowBack = false,
      this.leading,
      this.actions,
      this.backgroundColor = AppColor.white});

  @override
  _AppAppBarState createState() => _AppAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class _AppAppBarState extends State<AppAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      centerTitle: widget.centerTitle,
      actions: widget.actions,
      leading: widget.allowBack
          ? InkWell(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: widget.backgroundColor == AppColor.white
                    ? AppColor.black
                    : AppColor.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          : widget.leading,
      title: !isNull(widget.title)
          ? Text(
              widget.title,
              style: AppStyle.h3,
            )
          : null,
      elevation: 0,
    );
  }
}
