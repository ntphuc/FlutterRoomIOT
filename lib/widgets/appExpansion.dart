import 'package:flutter/material.dart';

class AppExpansion extends StatefulWidget {
  AppExpansion({@required this.header, this.children = const <Widget>[]});

  AppExpansion.builder(
      {@required this.header,
      @required this.itemCount,
      @required this.itemBuilder});

  final Widget header;
  List<Widget> children;
  int itemCount;
  Widget Function(int) itemBuilder;

  @override
  _CustomExpansionState createState() => _CustomExpansionState();
}

class _CustomExpansionState extends State<AppExpansion> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: widget.header,
        children:
            widget.itemCount != null ? _buildTileList() : widget.children);
  }

  List<Widget> _buildTileList() {
    List<Widget> tiles = [];
    for (int index = 0; index < widget.itemCount; index++)
      tiles.add(widget.itemBuilder(index));
    return tiles;
  }
}
