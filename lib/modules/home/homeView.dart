import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/addMeeting/addMeetingView.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/home/homeModel.dart';
import 'package:demo_b/modules/myMeeting/myMeetingView.dart';
import 'package:demo_b/modules/notification/notificationView.dart';
import 'package:demo_b/modules/roomMeeting/roomMeetingView.dart';
import 'package:demo_b/modules/setting/settingView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appBotNav.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<HomeModel>(
        model: HomeModel(),
        builder: (context, model, _) {
          return Scaffold(
            appBar: model.currentIndex != 3
                ? AppAppBar(
                    centerTitle: true,
                    title: '${ScreenUtil.t(model.currentTitle)}',
                  )
                : null,
            // drawer: AppDrawer(
            //   callback: (route) {
            //     model.navigate(route);
            //     Navigator.of(context).pop();
            //   },
            // ),
            bottomNavigationBar: AppBotNav(
              centerItemText: '${ScreenUtil.t(I18nKey.orderRoom)}',
              color: Colors.grey,
              backgroundColor: Colors.white,
              selectedColor: AppColor.primary,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (index) => model.navigate(index),
              items: [
                AppBotNavItem(
                    iconData: Icons.dashboard,
                    title: '${ScreenUtil.t(I18nKey.meetingRoom)}'),
                AppBotNavItem(
                    iconData: Icons.person,
                    title: '${ScreenUtil.t(I18nKey.my)}'),
                AppBotNavItem(
                    iconData: Icons.notifications,
                    title: '${ScreenUtil.t(I18nKey.notification)}'),
                AppBotNavItem(
                    iconData: Icons.menu,
                    title: '${ScreenUtil.t(I18nKey.more)}'),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.addMeeting);
              },
              child: Icon(Icons.add),
              elevation: 2.0,
            ),
            body: _buildView(model.currentIndex),
          );
        });
  }

  Widget _buildView(int index) {
    switch (index) {
      case 0:
        return RoomMeetingView();
      case 1:
        return MyMeetingView();
      case 2:
        return NotificationView();
      case 3:
        return SettingView();
      case 4:
        return AddMeetingView();
      default:
        return RoomMeetingView();
    }
  }
}
