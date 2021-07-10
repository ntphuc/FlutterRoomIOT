import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/notification/notificationModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<NotificationModel>(
      model: NotificationModel(),
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

  Widget _buildView(BuildContext context, NotificationModel model) {
    return Container(
      color: AppColor.white,
    );
  }
}
