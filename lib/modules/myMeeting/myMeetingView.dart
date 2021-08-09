import 'package:demo_b/configs/config.dart';
import 'package:demo_b/models/room/room_model.dart';
import 'package:demo_b/utils/toast.dart';
import 'package:demo_b/widgets/meetingTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/my_meeting/my_meeting_bloc.dart';
import '../../constants/appColor.dart';
import '../../core/locales/i18nKey.dart';
import '../../core/routes/routeName.dart';
import '../../utils/screenUtil.dart';
import '../../widgets/appInput.dart';
import '../../widgets/appSpinner.dart';
import '../../widgets/appTab.dart';
import '../../widgets/timelineTile.dart';
import '../base/baseView.dart';
import 'myMeetingModel.dart';

class MyMeetingView extends StatefulWidget {
  @override
  _MyMeetingViewState createState() => _MyMeetingViewState();
}

class _MyMeetingViewState extends State<MyMeetingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (context) => MyMeetingBloc()..add(MyMeetingFetchEvent()),
      child: BaseView<MyMeetingModel>(
        model: MyMeetingModel(),
        builder: (context, model, _) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Scaffold(
                  body: _buildView(context, model),
                ),
              ),
              model.loading ? AppSpinner() : Container()
            ],
          );
        },
      ),
    );
  }

  Widget _buildView(BuildContext context, MyMeetingModel model) {
    return BlocListener<MyMeetingBloc, MyMeetingState>(
      listener: (context, state) {
        // Check for the loading indicator
        // if (state is MyMeetingWaitingState) {
        //   model.setLoading(true);
        // } else {
        //   model.setLoading(false);
        // }
        if (state is MyMeetingExceptionState) {
          Toast.error(message: state.message??'');
        }
      },
      child: Container(
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
                    },
                  ),
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
                child: BlocBuilder<MyMeetingBloc, MyMeetingState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: (state is MyMeetingFetchDoneState)
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final meeting = state?.lsData?.elementAt(index);
                                RoomModel room = meeting.room as RoomModel;
                                return TimelineTile(
                                  time: AppConfig.dateFormat.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          meeting?.startTime ?? 0)),
                                  data: [
                                    MeetingItem(
                                      start: AppConfig.timeFormat.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              meeting?.startTime ?? 0)),
                                      end: AppConfig.timeFormat.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              meeting?.endTime ?? 0)),
                                      title: meeting?.name ?? '',
                                      room: room?.name ?? '',
                                      meetingId: meeting?.id ?? '',
                                    )
                                  ],
                                  type: index % 3,
                                );
                              },
                              itemCount: state.lsData?.length ?? 0,
                            )
                          : Center(
                              child: CupertinoActivityIndicator(),
                            ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
