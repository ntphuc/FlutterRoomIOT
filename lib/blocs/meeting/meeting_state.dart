part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState {}

class MeetingInitialState extends MeetingState {}

class MeetingWaitingState extends MeetingState {}

class MeetingFetchDoneState extends MeetingState {
  final List<MeetingModel> lsData;

  MeetingFetchDoneState(this.lsData);
}

class MeetingFetchFailState extends MeetingState {
  final String code;
  final String message;

  MeetingFetchFailState({
    this.code,
    this.message,
  });
}

class MeetingExceptionState extends MeetingState {
  final String code;
  final String message;

  MeetingExceptionState({
    this.code,
    this.message,
  });
}
