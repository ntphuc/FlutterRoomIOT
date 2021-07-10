import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/roomMeeting/roomMeetingModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/appTab.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RoomMeetingView extends StatefulWidget {
  @override
  _RoomMeetingViewState createState() => _RoomMeetingViewState();
}

class _RoomMeetingViewState extends State<RoomMeetingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<RoomMeetingModel>(
      model: RoomMeetingModel(),
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

  Widget _buildView(BuildContext context, RoomMeetingModel model) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.rooms.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: AppTab(
                    title: model.rooms[index],
                    selected: model.currentTab == index,
                    onPressed: () {
                      model.changeTab(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.day,
            ),
          )
        ],
      ),
    );
  }
}
