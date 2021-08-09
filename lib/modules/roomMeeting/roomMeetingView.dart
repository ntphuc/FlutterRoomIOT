import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../blocs/meeting/meeting_bloc.dart';
import '../../blocs/room/room_bloc.dart';
import '../../constants/appColor.dart';
import '../../models/meeting/meeting_model.dart';
import '../../services/chart/meeting_datasource.dart';
import '../../utils/screenUtil.dart';
import '../../utils/toast.dart';
import '../../widgets/appSpinner.dart';
import '../../widgets/appTab.dart';
import '../base/baseView.dart';
import '../roomMeetingDetail/room_meeting_detail.dart';
import 'roomMeetingModel.dart';

class RoomMeetingView extends StatefulWidget {
  @override
  _RoomMeetingViewState createState() => _RoomMeetingViewState();
}

class _RoomMeetingViewState extends State<RoomMeetingView> {
  CalendarController controller = CalendarController();
  DateTime currentDate;
  BuildContext currentContext;
  final lsColor = [
    Color(0xffEDEDF8),
    Color(0xffFCF3E4),
    Color(0xffEBFAED),
  ];

  final _rand = Random();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getRandomColor() {
    return lsColor[_rand.nextInt(lsColor.length)];
  }

  getMeeting(
    String roomId, {
    int start,
    int end,
  }) {
    final now = DateTime.now();
    final startTime =
        DateTime(now.year, now.month, now.day, 0, 0, 0).millisecondsSinceEpoch;
    final endTime = DateTime(now.year, now.month, now.day, 23, 59, 59)
        .millisecondsSinceEpoch;
    BlocProvider.of<MeetingBloc>(currentContext).add(MeetingFetchEvent(
        roomId: roomId,
        startTime: start ?? startTime,
        endTime: end ?? endTime));
    final save = DateTime.fromMillisecondsSinceEpoch(start ?? startTime);
    currentDate = DateTime(save.year, save.month, save.day);
  }

  List<TimeCalendar> _getDataSource(List<MeetingModel> ls) {
    final List<TimeCalendar> meetings = <TimeCalendar>[];
    for (final item in ls) {
      meetings.add(
        TimeCalendar(
          id: item.id,
          eventName: item.name ?? '',
          from: DateTime.fromMillisecondsSinceEpoch(item.startTime),
          to: DateTime.fromMillisecondsSinceEpoch(item.endTime),
          background: getRandomColor(),
          note: item.description,
        ),
      );
    }
    return meetings;
  }

  Widget _buildView(BuildContext context, RoomMeetingModel model) {
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomFetchDoneState) {
          model.lsData = state.lsData;
          getMeeting(model.getCurrentRoom().id);
        }
        // Check for the loading indicator
        // if (state is RoomWaitingState) {
        //   model.setLoading(true);
        // } else {
        //   model.setLoading(false);
        // }
        if (state is RoomExceptionState) {
          Toast.error(message: state.message ?? '');
        }
      },
      child: BlocListener<MeetingBloc, MeetingState>(
        listener: (context, state) {
          // Check for the loading indicator
          if (state is RoomWaitingState) {
            model.setLoading(true);
          } else {
            model.setLoading(false);
          }
          if (state is MeetingExceptionState) {
            Toast.error(message: state.message ?? '');
          }
        },
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: BlocBuilder<RoomBloc, RoomState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: (state is RoomFetchDoneState)
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.lsData?.length ?? 0,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: AppTab(
                                    title: state.lsData[index].name ?? '',
                                    selected: model.currentTab == index,
                                    onPressed: () {
                                      model.changeTab(index);
                                      //Get detail meeting
                                      getMeeting(model.getCurrentRoom().id);
                                      /* Navigator.of(context)
                                            ..push(
                                              MaterialPageRoute(
                                                builder: (_) => RoomMeetingDetail(),
                                              ),
                                            ); */
                                    },
                                  ),
                                ),
                              ),
                            )
                          : (state is RoomFetchFailState ||
                                  state is RoomExceptionState)
                              ? InkWell(
                                  onTap: () {
                                    BlocProvider.of<RoomBloc>(context)
                                        .add(RoomFetchEvent());
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.refresh_outlined,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                    );
                  },
                ),
              ),
              BlocBuilder<MeetingBloc, MeetingState>(
                builder: (context, state) {
                  currentContext = context;
                  return Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: (state is MeetingFetchDoneState)
                          ? SfCalendar(
                              view: CalendarView.day,
                              dataSource: MeetingDataSource(
                                _getDataSource(state.lsData),
                              ),
                              appointmentTextStyle: TextStyle(
                                color: Colors.black,
                              ),
                              controller: controller,
                              onTap: (val) {
                                final currentAppointment =
                                    (val?.appointments?.first) as TimeCalendar;
                                print(currentAppointment?.id);
                                if (currentAppointment?.id != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RoomMeetingDetail(
                                        meetingId: currentAppointment.id,
                                      ),
                                    ),
                                  );
                                }
                              },
                              onViewChanged: (detail) {
                                print(detail.visibleDates);
                                final _date = detail.visibleDates.first;
                                if (DateTime(
                                        _date.year, _date.month, _date.day) !=
                                    currentDate) {
                                  final startTime = DateTime(_date.year,
                                          _date.month, _date.day, 0, 0, 0)
                                      .millisecondsSinceEpoch;
                                  final endTime = DateTime(_date.year,
                                          _date.month, _date.day, 23, 59, 59)
                                      .millisecondsSinceEpoch;
                                  getMeeting(
                                    model.getCurrentRoom().id,
                                    start: startTime,
                                    end: endTime,
                                  );
                                }
                              },
                            )
                          : (state is MeetingFetchFailState ||
                                  state is MeetingExceptionState)
                              ? InkWell(
                                  onTap: () {
                                    getMeeting(model.getCurrentRoom().id);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.refresh_rounded,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocProvider(
      create: (context) => RoomBloc()..add(RoomFetchEvent()),
      child: BlocProvider(
        create: (context) => MeetingBloc(),
        child: BaseView<RoomMeetingModel>(
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
        ),
      ),
    );
  }
}
