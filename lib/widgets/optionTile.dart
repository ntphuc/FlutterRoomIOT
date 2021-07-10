import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class OptionItem {
  IconData iconData;
  String title;

  OptionItem({@required this.iconData, @required this.title});
}

class OptionTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() onPressed;

  OptionTile({@required this.iconData, @required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return ListTile(
      leading: Icon(iconData),
      title: Text(
        '${ScreenUtil.t(title)}',
        style: AppStyle.title1,
      ),
      onTap: onPressed,
    );
  }
}
