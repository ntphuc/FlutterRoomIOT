import 'package:demo_b/models/control/room.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/services/controlService.dart';
import 'package:demo_b/utils/toast.dart';

class RoomListControlModel extends BaseModel {
  ControlService _controlService = ControlService.instance();
  List<Room> list = [];

  Future<void> getRoomList() async {
    setLoading(true);
    try {
      List<Room> rooms = (await _controlService.getRoomList()).data;
      rooms.sort((a, b) => a.name.compareTo(b.name));
      list = rooms;
      notifyListeners();
    } catch (error) {
      Toast.error(message: error.message);
    } finally {
      setLoading(false);
    }
  }
}
