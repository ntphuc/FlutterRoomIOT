import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/widgets/meetingTile.dart';
import 'package:flutter/material.dart';

class TimelineItem {
  String time;
  List<MeetingItem> data;

  TimelineItem({@required this.time, @required this.data});
}

class TimelineTile extends StatefulWidget {
  final String time;
  final List<MeetingItem> data;
  final int type;

  TimelineTile({@required this.time, @required this.data, this.type});

  @override
  _TimelineTileState createState() => _TimelineTileState();
}

class _TimelineTileState extends State<TimelineTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Text(
            widget.time,
            style: AppStyle.h3,
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => MeetingTile(
            start: widget.data[index].start,
            end: widget.data[index].end,
            title: widget.data[index].title,
            room: widget.data[index].room,
            type: widget.type,
          ),
          itemCount: widget.data.length,
        )
      ],
    );
  }
}
