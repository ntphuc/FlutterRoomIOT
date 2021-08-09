import '../../models/room/room_model.dart';
import '../base/baseModel.dart';

class RoomMeetingModel extends BaseModel {
  int currentTab = 0;
  List<RoomModel> lsData = [];
  // List<String> rooms = ['phòng họp 1', 'phòng họp 2'];

  RoomModel getCurrentRoom() {
    return lsData[currentTab];
  }

  void changeTab(int value) {
    if (value == currentTab) return;
    currentTab = value;
    notifyListeners();
  }
}
