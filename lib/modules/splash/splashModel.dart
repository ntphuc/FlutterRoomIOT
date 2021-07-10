import 'package:demo_b/modules/base/baseModel.dart';

class SplashModel extends BaseModel {
  Future<void> init() async {
    await Future<dynamic>.delayed(Duration(seconds: 2));
  }
}
