import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/splash/splashModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/logo.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SplashModel>(
      model: SplashModel(),
      onModelReady: (model) async {
        await model.init();
        Navigator.of(context).pushReplacementNamed(RouteName.signIn);
      },
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, SplashModel model) {
    return Container(
        color: AppColor.white,
        child: Center(
          child: Logo(),
        ));
  }
}
