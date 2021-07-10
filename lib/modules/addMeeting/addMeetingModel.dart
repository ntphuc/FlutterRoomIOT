import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/widgets/orderRoomTile.dart';
import 'package:flutter/cupertino.dart';

class AddMeetingModel extends BaseModel {
  BuildContext context;

  AddMeetingModel(this.context);

  List<String> data = [
    'Phòng họp 1',
    '28/06/2021, 08:48',
    '28/06/2021, 09:48',
    'Không bao giờ',
    '1'
  ];

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
