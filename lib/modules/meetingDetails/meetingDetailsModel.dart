import 'package:demo_b/modules/base/baseModel.dart';

class MeetingDetails {
  String title;
  String room;
  String start;
  String end;
  String time;
  String orderer;
  String status;
  List<String> participants;

  MeetingDetails(
      {this.title,
      this.room,
      this.start,
      this.end,
      this.time,
      this.orderer,
      this.status,
      this.participants});
}

class MeetingDetailsModel extends BaseModel {
  MeetingDetails meetingDetails = MeetingDetails(
      title: 'cuộc họp 1',
      room: 'phòng 1',
      start: '12:15',
      end: '13:15',
      time: 'Thứ 4, 30/05/2021',
      orderer: 'Ngo Anh Duong',
      status: 'Sắp diễn ra',
      participants: ['duonganh@gmail.com', 'bach@gmail.com']);
}
