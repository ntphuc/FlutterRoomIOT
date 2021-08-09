import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/meeting_detail/meeting_detail_bloc.dart';
import '../../configs/config.dart';
import '../../constants/appColor.dart';
import '../../constants/appStyle.dart';
import '../../models/room/room_model.dart';
import '../../repositories/room/room_res.dart';
import '../../utils/screenUtil.dart';
import '../../utils/toast.dart';
import '../../widgets/appAppBar.dart';
import '../../widgets/appSpinner.dart';
import '../base/baseView.dart';
import 'meetingDetailsModel.dart';

class MeetingDetailsView extends StatefulWidget {
  const MeetingDetailsView({Key key, this.meetingId}) : super(key: key);

  final String meetingId;

  @override
  _MeetingDetailsViewState createState() => _MeetingDetailsViewState();
}

class _MeetingDetailsViewState extends State<MeetingDetailsView> {
  String getStatus(int start, int end) {
    if (DateTime.now().millisecondsSinceEpoch < start) {
      return 'Sắp diễn ra';
    } else if (DateTime.now().millisecondsSinceEpoch > end) {
      return 'Đã diễn ra';
    } else {
      return 'Đang diễn ra';
    }
  }

  Widget _buildView(BuildContext context, MeetingDetailsModel model) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primary,
        // image: DecorationImage(
        //   image: AssetImage('assets/images/demos/Artwork Top.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: BlocListener<MeetingDetailBloc, MeetingDetailState>(
        listener: (context, state) {
          if (state is MeetingDetailFetchFailState) {
            Toast.error(message: state.message ?? '');
          } else if (state is MeetingDetailExceptionState) {
            Toast.error(message: state.message ?? '');
          }
        },
        child: BlocBuilder<MeetingDetailBloc, MeetingDetailState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: (state is MeetingDetailFetchDoneState)
                  ? Builder(
                      builder: (context) {
                        final meeting = state.data;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                meeting?.name ?? '',
                                style: AppStyle.title1White,
                              ),
                            ),
                            Text(
                              meeting?.description ?? '',
                              style: AppStyle.title1White,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppConfig.timeFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            meeting?.startTime ?? 0)),
                                    style: AppStyle.h0White,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: AppColor.white,
                                    ),
                                  ),
                                  Text(
                                    AppConfig.timeFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            meeting?.endTime ?? 0)),
                                    style: AppStyle.h0White,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              AppConfig.dateFormat.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      meeting?.startTime ?? 0)),
                              style: AppStyle.title2White,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Lặp lại: ${meeting?.repeat ?? 0}',
                                style: AppStyle.title2White,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Nhắc nhở: ${(meeting?.remind ?? false) ? 'Có' : 'Không'}',
                                style: AppStyle.title2White,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 32),
                              child: Text(
                                getStatus(meeting?.startTime ?? 0,
                                    meeting?.endTime ?? 0),
                                style: AppStyle.h1White,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<RoomModel>(
                                    future: RoomRes()
                                        .getRoomDetail(meeting?.room ?? ''),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            /* Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    RoomMeetingDetail(),
                                              ),
                                            ); */
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  snapshot?.data?.name ?? '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      return CupertinoActivityIndicator();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                width: ScreenUtil.width,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 20, 16, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          'Người tham gia (${meeting?.members?.length ?? 0})',
                                          style: AppStyle.h4,
                                        ),
                                      ),
                                      /* ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, bottom: 6),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16),
                                                child: CircleAvatar(),
                                              ),
                                              Text(model.meetingDetails
                                                  .participants[index])
                                            ],
                                          ),
                                        ),
                                        itemCount: model
                                            .meetingDetails.participants.length,
                                      ) */
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (context) => MeetingDetailBloc()
        ..add(MeetingDetailFetchEvent(meetingId: widget.meetingId)),
      child: BaseView<MeetingDetailsModel>(
        model: MeetingDetailsModel(),
        builder: (context, model, _) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Scaffold(
                appBar: AppAppBar(
                  backgroundColor: AppColor.primary,
                  allowBack: true,
                ),
                body: _buildView(context, model),
              ),
              model.loading ? AppSpinner() : Container()
            ],
          );
        },
      ),
    );
  }
}
