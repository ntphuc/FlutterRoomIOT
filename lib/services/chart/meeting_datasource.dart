import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<TimeCalendar> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getNotes(int index) {
    return appointments[index].note;
  }
}

class TimeCalendar {
  TimeCalendar({
    this.id,
    this.eventName,
    this.note,
    this.from,
    this.to,
    this.background,
    this.isAllDay = false,
  });
  String id;
  String eventName;
  String note;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
