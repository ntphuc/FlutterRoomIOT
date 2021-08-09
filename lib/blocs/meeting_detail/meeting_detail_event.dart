part of 'meeting_detail_bloc.dart';

@immutable
abstract class MeetingDetailEvent {}

class MeetingDetailFetchEvent extends MeetingDetailEvent {
  final String meetingId;

  MeetingDetailFetchEvent({@required this.meetingId});
}
