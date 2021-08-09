import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectRepeatItem {
  String title;
  bool selected;
  int value;

  SelectRepeatItem({
    @required this.title,
    @required this.value,
    this.selected = false,
  });
}

class SelectRepeatTile extends StatefulWidget {
  final String title;
  final bool selected;
  final Function(bool) onChanged;

  SelectRepeatTile(
      {@required this.title, @required this.selected, this.onChanged});

  @override
  _SelectRepeatTileState createState() => _SelectRepeatTileState();
}

class _SelectRepeatTileState extends State<SelectRepeatTile> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return CheckboxListTile(
        title: Text(
          '${ScreenUtil.t(widget.title)}',
          style: AppStyle.title2,
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        value: widget.selected,
        onChanged: widget.onChanged);
  }
}
