import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class OrderRoomItem {
  String title;

  OrderRoomItem({@required this.title});
}

class OrderRoomTile extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;

  OrderRoomTile({@required this.title, @required this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return ListTile(
      onTap: onPressed,
      leading: Text(
        '${ScreenUtil.t(title)}',
        style: AppStyle.title2Grey,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text(
              '${content}',
              style: AppStyle.h4,
            ),
          ),
          Icon(title == I18nKey.start || title == I18nKey.end
              ? Icons.calendar_today
              : Icons.arrow_forward_ios_outlined)
        ],
      ),
    );
  }
}
