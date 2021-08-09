import 'package:demo_b/configs/config.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/repositories/room/room_res.dart';
import 'package:demo_b/widgets/orderRoomTile.dart';
import 'package:flutter/cupertino.dart';

class AddMeetingModel extends BaseModel {
  BuildContext context;

  MeetingModel model;
  String dropdownValue = 'Audio and Video call';
  List<String> dropdownList = [
    'Audio and Video call',
    'Video call',
    'Audio call',
    'Presentation',
    'Discussion'
  ];

  void onDropdownChanged(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  _getRepeatString(int i) {
    switch (i) {
      case 1:
        return 'Hàng ngày';
      case 2:
        return 'Hàng tuần';
      case 3:
        return 'Hàng tháng';
      case 4:
        return 'Hàng năm';

      default:
        return 'Không bao giờ';
    }
  }

  init({MeetingModel initModel}) async {
    if (initModel != null) {
      model = initModel;
      updateStart(
          DateTime.fromMillisecondsSinceEpoch(initModel?.startTime ?? 0));
      updateEnd(DateTime.fromMillisecondsSinceEpoch(initModel?.endTime ?? 0));
      RoomRes().getRoomDetail(initModel.room as String).then((room) {
        if (room != null) {
          updateRoom(room?.name ?? '');
        }
      });
      updaterepeat(_getRepeatString(initModel?.repeat ?? 0));
      updateMember(initModel?.members?.length ?? 0);
    } else {
      model = MeetingModel();
    }
  }

  AddMeetingModel(
    this.context,
  );

  List<String> data = [
    'Chưa chọn',
    '--/--/----, 00:00',
    '--/--/----, 00:00',
    'Chưa chọn',
    '0'
  ];

  void updateStart(DateTime start) {
    data[1] = AppConfig.dateFormat2.format(start);
    model.startTime = start.millisecondsSinceEpoch;
    notifyListeners();
  }

  void updateEnd(DateTime end) {
    data[2] = AppConfig.dateFormat2.format(end);
    model.endTime = end.millisecondsSinceEpoch;
    notifyListeners();
  }

  void updateRoom(String roomName) {
    data[0] = roomName;
    notifyListeners();
  }

  void updateMember(int numMem) {
    data[4] = numMem.toString();
    notifyListeners();
  }

  void updaterepeat(String repeat) {
    data[3] = repeat;
    notifyListeners();
  }

  List<OrderRoomItem> items = [
    OrderRoomItem(
      title: I18nKey.meetingRoom,
    ),
    OrderRoomItem(
      title: I18nKey.start,
    ),
    OrderRoomItem(
      title: I18nKey.end,
    ),
    OrderRoomItem(
      title: I18nKey.repeat,
    ),
    OrderRoomItem(
      title: I18nKey.participant,
    ),
  ];
}
