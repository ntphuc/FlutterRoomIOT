import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/myMeeting/myMeetingModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appInput.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/appTab.dart';
import 'package:demo_b/widgets/timelineTile.dart';
import 'package:flutter/material.dart';

class MyMeetingView extends StatefulWidget {
  @override
  _MyMeetingViewState createState() => _MyMeetingViewState();
}

class _MyMeetingViewState extends State<MyMeetingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<MyMeetingModel>(
      model: MyMeetingModel(),
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

  Widget _buildView(BuildContext context, MyMeetingModel model) {
    return Container(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppInput(
                    outlined: true,
                    hintText: '${ScreenUtil.t(I18nKey.search)}',
                    search: true,
                    onSearch: () {},
                  ),
                ),
                InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteName.meetingCalendar);
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: AppTab(
                      title: 'Liên quan đến tôi',
                      selected: model.currentTab == 0,
                      onPressed: () {
                        model.changeTab(0);
                      },
                    ),
                  ),
                  AppTab(
                    title: 'Lịch họp tôi đặt',
                    selected: model.currentTab == 1,
                    onPressed: () {
                      model.changeTab(1);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => TimelineTile(
                  time: model.items[index].time,
                  data: model.items[index].data,
                  type: index % 3,
                ),
                itemCount: model.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
