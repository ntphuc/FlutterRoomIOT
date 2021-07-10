import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class AppOrientation extends StatelessWidget {
  AppOrientation(
      {@required this.children,
      this.mainAxisSize = MainAxisSize.max,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      width: ScreenUtil.width,
      height: ScreenUtil.height,
      child: ScreenUtil.orientation == Orientation.portrait
          ? Column(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: children)
          : Row(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: children),
    );
  }
}
