import 'package:demo_b/blocs/my_meeting/my_meeting_bloc.dart';
import 'package:demo_b/modules/roomMeetingDetail/room_meeting_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/appStyle.dart';

class MeetingItem {
  String start;
  String end;
  String title;
  String room;
  String meetingId;

  MeetingItem({
    @required this.start,
    @required this.end,
    @required this.title,
    @required this.room,
    @required this.meetingId,
  });
}

class MeetingTile extends StatefulWidget {
  final String start;
  final String end;
  final String title;
  final String room;
  final String meetingId;
  final int type;

  MeetingTile({
    @required this.start,
    @required this.end,
    @required this.title,
    @required this.room,
    @required this.meetingId,
    this.type,
  });

  @override
  _MeetingTileState createState() => _MeetingTileState();
}

class _MeetingTileState extends State<MeetingTile> {
  Color getBackgroundColor(int type) {
    switch (type) {
      case 1:
        return Color(0xffEDEDF8);
      case 2:
        return Color(0xffFCF3E4);
      default:
        return Color(0xffEBFAED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.start,
                    style: AppStyle.content,
                  ),
                ),
                Text(
                  widget.end,
                  style: AppStyle.content,
                )
              ],
            ),
          ),
          Expanded(
              child: InkWell(
            onTap: () async {
              // Navigator.of(context).pushNamed(RouteName.meetingDetails);
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RoomMeetingDetail(
                    meetingId: widget.meetingId,
                  ),
                ),
              );
              BlocProvider.of<MyMeetingBloc>(context)
                  .add(MyMeetingFetchEvent());
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        widget.title,
                        style: AppStyle.h4,
                      ),
                    ),
                    Text(
                      widget.room,
                      style: AppStyle.content,
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: getBackgroundColor(widget.type),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
