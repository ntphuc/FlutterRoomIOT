import 'package:demo_b/constants/appImage.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60, height: 60, child: Image(image: AssetImage(AppImage.logo)));
  }
}
