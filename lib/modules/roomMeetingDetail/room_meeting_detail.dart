import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../blocs/meeting_detail/meeting_detail_bloc.dart';
import '../../configs/config.dart';
import '../../models/room/room_model.dart';
import '../../models/user/user_model.dart';
import '../../repositories/room/room_res.dart';
import '../../repositories/user/user_res.dart';
import '../../utils/toast.dart';
import '../addMeeting/addMeetingView.dart';

class RoomMeetingDetail extends StatefulWidget {
  const RoomMeetingDetail({
    this.meetingId,
    Key key,
  }) : super(key: key);
  final String meetingId;
  @override
  _RoomMeetingDetailState createState() => _RoomMeetingDetailState();
}

class _RoomMeetingDetailState extends State<RoomMeetingDetail> {
  String getStatus(int start, int end) {
    if (DateTime.now().millisecondsSinceEpoch < start) {
      return 'Sắp diễn ra';
    } else if (DateTime.now().millisecondsSinceEpoch > end) {
      return 'Đã diễn ra';
    } else {
      return 'Đang diễn ra';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeetingDetailBloc()
        ..add(MeetingDetailFetchEvent(meetingId: widget.meetingId)),
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
                  ? Scaffold(
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        leading: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                        ),
                        title: Text(
                          (state.data?.name ?? ''),
                          style: TextStyle(color: Colors.black),
                        ),
                        centerTitle: true,
                      ),
                      body: SingleChildScrollView(
                        child: Builder(
                          builder: (context) {
                            final meeting = state.data;
                            return Container(
                              child: Column(
                                children: [
                                  FadeInImage(
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: AssetImage(
                                      'assets/images/demos/Artwork Top.png',
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tên sự kiện',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFDF1DB),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xffDCCCA0),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                  child: Text(
                                                    getStatus(
                                                        meeting?.startTime ?? 0,
                                                        meeting?.endTime ?? 0),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              meeting?.name ?? '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Loại:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    84, 84, 84, 1),
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 40,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xff3ECFCD),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                  child: Text(
                                                    'Audio and Video call',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    color: Color(0xffe8e3e3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Người tham dự',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        FutureBuilder<UserModel>(
                                          future: UserRes().getUserById(
                                              meeting?.userBooked ?? 'x'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final user = snapshot.data;
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 3.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          user?.fullname ?? '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                          '(Hosted)',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        user?.email ?? '',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff545454),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CupertinoActivityIndicator()
                                              ],
                                            );
                                          },
                                        ),
                                        Divider(thickness: 2),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (contextDialog) {
                                                  final futures =
                                                      (meeting?.members ?? [])
                                                          .map((e) => UserRes()
                                                              .getUserById(e))
                                                          .toList();
                                                  return AlertDialog(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Người tham dự')
                                                      ],
                                                    ),
                                                    content: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      child: Container(
                                                        child: FutureBuilder<
                                                            List<UserModel>>(
                                                          future: Future.wait(
                                                              futures),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .builder(
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final user =
                                                                      snapshot.data[
                                                                          index];
                                                                  return Card(
                                                                    child:
                                                                        ListTile(
                                                                      title: Text(
                                                                          user?.fullname ??
                                                                              ''),
                                                                      subtitle: Text(
                                                                          user?.email ??
                                                                              ''),
                                                                    ),
                                                                  );
                                                                },
                                                                itemCount: snapshot
                                                                        .data
                                                                        ?.length ??
                                                                    0,
                                                              );
                                                            }
                                                            return Center(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 3.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '${meeting?.members?.length ?? 0} người tham dự',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${meeting?.members?.length ?? 0} chấp nhận',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff545454),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Colors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    color: Color(0xffe8e3e3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Thời gian',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 3.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  color: Color(0xffeae8e8),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: Center(
                                                      child: Text(
                                                        AppConfig.dateFormat2
                                                            .format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    meeting?.startTime ??
                                                                        0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.0),
                                              Expanded(
                                                child: Container(
                                                  color: Color(0xffeae8e8),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: Center(
                                                      child: Text(
                                                        AppConfig.dateFormat2
                                                            .format(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                              meeting?.endTime ??
                                                                  0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Địa điểm',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 3.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  color: Color(0xffeae8e8),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0),
                                                    child: Center(
                                                      child: FutureBuilder<
                                                          RoomModel>(
                                                        future: RoomRes()
                                                            .getRoomDetail(
                                                                meeting?.room ??
                                                                    ''),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot?.data
                                                                      ?.name ??
                                                                  '',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            );
                                                          }
                                                          return CupertinoActivityIndicator();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Ghi chú',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  color: Color(0xffeae8e8),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 8.0),
                                                    child: Center(
                                                      child: Text(
                                                        meeting?.note ?? '',
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    color: Color(0xffe8e3e3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tự động đặt phòng',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Center(
                                                child: Text(
                                                  'Theo hằng ngày',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            final res =
                                                await Navigator.of(context)
                                                    .push(
                                              MaterialPageRoute(
                                                builder: (_) => AddMeetingView(
                                                  initModel: state.data.copyWith(),
                                                ),
                                              ),
                                            );
                                            if (res ?? false) {
                                              BlocProvider.of<
                                                          MeetingDetailBloc>(
                                                      context)
                                                  .add(MeetingDetailFetchEvent(
                                                      meetingId:
                                                          widget.meetingId));
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            color: Color(0xff276EF1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: Center(
                                                child: Text(
                                                  'Chỉnh sửa',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        leading: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                        ),
                        title: SizedBox.shrink(),
                        centerTitle: true,
                      ),
                      body: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoActivityIndicator(),
                              SizedBox(height: 10),
                              Text(
                                'Đang tải...',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
