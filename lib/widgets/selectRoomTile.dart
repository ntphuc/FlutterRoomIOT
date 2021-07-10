import 'package:demo_b/constants/appStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectRoomItem {
  String name;
  String description;
  bool selected;

  SelectRoomItem(
      {@required this.name, @required this.description, this.selected = false});
}

class SelectRoomTile extends StatefulWidget {
  final String name;
  final String description;
  final bool selected;
  final Function(bool) onChanged;

  SelectRoomTile(
      {@required this.name,
      @required this.description,
      @required this.selected,
      this.onChanged});

  @override
  _SelectRoomTileState createState() => _SelectRoomTileState();
}

class _SelectRoomTileState extends State<SelectRoomTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(
          '${widget.name}',
          style: AppStyle.title2,
        ),
        subtitle: Text(
          '${widget.description}',
          style: AppStyle.subtitle1Grey,
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        value: widget.selected,
        onChanged: widget.onChanged);
  }
}
