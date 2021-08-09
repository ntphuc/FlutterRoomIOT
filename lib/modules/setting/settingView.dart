import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/setting/settingModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/utils/toast.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SettingModel>(
      model: SettingModel(context),
      onModelReady: (model) async {
        await model.init();
      },
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, SettingModel model) {
    // ThemeModel themeModel = Provider.of<ThemeModel>(context);
    // LocaleModel localeModel = Provider.of<LocaleModel>(context);
    return Container(
      color: AppColor.white,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.width,
            height: ScreenUtil.height / 3.5,
            color: AppColor.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    '${model.currentUser?.fullname ?? ''}',
                    style: AppStyle.h2White,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    '${model.currentUser?.email ?? ''}',
                    style: AppStyle.contentWhite,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Visibility(
                visible: model.currentUser?.admin ?? false,
                child: ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text('Admin Control'),
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.roomListControl);
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Đánh giá ứng dụng'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Phản hồi'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Thông tin sản phẩm'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Đăng xuất'),
                onTap: () async {
                  await model.signOut();
                },
              ),
              SizedBox(
                height: 25,
              ),
              Divider(
                indent: 35,
              ),
              ListTile(
                onLongPress: () async {
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  await Clipboard.setData(ClipboardData(text: fcmToken));
                  // Toast.success(message: 'Done');
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) => Text(
                        snapshot?.data?.version ?? '',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
