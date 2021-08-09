import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectParticipantItem {
  String id;
  String title;
  String avatar;
  bool selected;

  SelectParticipantItem({
    @required this.id,
    @required this.title,
    @required this.avatar,
    this.selected = false,
  });
}

class SelectParticipantTile extends StatefulWidget {
  final String title;
  final String avatar;
  final bool selected;
  final Function(bool) onChanged;

  SelectParticipantTile(
      {@required this.title,
      @required this.avatar,
      @required this.selected,
      this.onChanged});

  @override
  _SelectParticipantTileState createState() => _SelectParticipantTileState();
}

class _SelectParticipantTileState extends State<SelectParticipantTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(),
          ),
          Text(
            '${widget.title}',
            style: AppStyle.title2,
          ),
        ],
      ),
      controlAffinity: ListTileControlAffinity.trailing,
      value: widget.selected,
      onChanged: widget.onChanged,
    );
  }
}
