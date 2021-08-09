part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent {}

class MeetingFetchEvent extends MeetingEvent {
  final String roomId;
  final int startTime, endTime;

  MeetingFetchEvent({
    @required this.roomId,
    @required this.startTime,
    @required this.endTime,
  });
}
