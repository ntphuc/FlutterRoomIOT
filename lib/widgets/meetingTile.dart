import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:flutter/material.dart';

class MeetingItem {
  String start;
  String end;
  String title;
  String room;

  MeetingItem(
      {@required this.start,
      @required this.end,
      @required this.title,
      @required this.room});
}

class MeetingTile extends StatefulWidget {
  final String start;
  final String end;
  final String title;
  final String room;
  final int type;

  MeetingTile(
      {@required this.start,
      @required this.end,
      @required this.title,
      @required this.room,
      this.type});

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
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.meetingDetails);
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
