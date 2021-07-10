import 'package:demo_b/modules/base/baseModel.dart';

class RoomMeetingModel extends BaseModel {
  int currentTab = 0;
  List<String> rooms = ['phòng họp 1', 'phòng họp 2'];

  void changeTab(int value) {
    if (value == currentTab) return;
    currentTab = value;
    notifyListeners();
  }
}
