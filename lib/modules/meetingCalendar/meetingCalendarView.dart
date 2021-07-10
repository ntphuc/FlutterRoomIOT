import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/meetingCalendar/meetingCalendarModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingCalendarView extends StatefulWidget {
  @override
  _MeetingCalendarViewState createState() => _MeetingCalendarViewState();
}

class _MeetingCalendarViewState extends State<MeetingCalendarView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<MeetingCalendarModel>(
      model: MeetingCalendarModel(),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                allowBack: true,
              ),
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, MeetingCalendarModel model) {
    return SfCalendar(
      view: CalendarView.month,
    );
  }
}
