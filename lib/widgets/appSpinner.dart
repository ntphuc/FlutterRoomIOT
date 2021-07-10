import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      width: ScreenUtil.width,
      height: ScreenUtil.height,
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
