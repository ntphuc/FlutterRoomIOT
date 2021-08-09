part of 'my_meeting_bloc.dart';

@immutable
abstract class MyMeetingState {}

class MyMeetingInitialState extends MyMeetingState {}

class MyMeetingWaitingState extends MyMeetingState {}

class MyMeetingFetchDoneState extends MyMeetingState {
  final List<MeetingModel> lsData;

  MyMeetingFetchDoneState(this.lsData);
}

class MyMeetingFetchFailState extends MyMeetingState {
  final String code;
  final String message;

  MyMeetingFetchFailState({
    this.code,
    this.message,
  });
}

class MyMeetingExceptionState extends MyMeetingState {
  final String code;
  final String message;

  MyMeetingExceptionState({
    this.code,
    this.message,
  });
}
