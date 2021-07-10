import 'package:demo_b/constants/appImage.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({@required this.callback});

  final Function(String) callback;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        ListTile(
          title: Text('${ScreenUtil.t(I18nKey.meetingRoom)}'),
          leading: const Icon(AppImage.main1Icon),
          onTap: () => widget.callback(RouteName.roomMeeting),
        ),
        ListTile(
          title: Text('${ScreenUtil.t(I18nKey.my)}'),
          leading: const Icon(AppImage.main2Icon),
          onTap: () => widget.callback(RouteName.myMeeting),
        ),
        ListTile(
          leading: const Icon(AppImage.main3Icon),
          onTap: () => widget.callback(RouteName.addMeeting),
        ),
        ListTile(
          title: Text('${ScreenUtil.t(I18nKey.notification)}'),
          leading: const Icon(AppImage.main4Icon),
          onTap: () => widget.callback(RouteName.notification),
        ),
        ListTile(
          title: Text('${ScreenUtil.t(I18nKey.more)}'),
          leading: const Icon(AppImage.settingIcon),
          onTap: () => widget.callback(RouteName.setting),
        ),
        ListTile(
          title: Text('${ScreenUtil.t(I18nKey.signOut)}'),
          leading: const Icon(AppImage.signOutIcon),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(RouteName.signIn),
        ),
      ]),
    );
  }
}
