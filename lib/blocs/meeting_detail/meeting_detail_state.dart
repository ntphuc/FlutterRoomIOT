part of 'meeting_detail_bloc.dart';

@immutable
abstract class MeetingDetailState {}

class MeetingDetailInitialState extends MeetingDetailState {}

class MeetingDetailWaitingState extends MeetingDetailState {}

class MeetingDetailFetchDoneState extends MeetingDetailState {
  final MeetingModel data;

  MeetingDetailFetchDoneState(this.data);
}

class MeetingDetailFetchFailState extends MeetingDetailState {
  final String code;
  final String message;

  MeetingDetailFetchFailState({
    this.code,
    this.message,
  });
}

class MeetingDetailExceptionState extends MeetingDetailState {
  final String code;
  final String message;

  MeetingDetailExceptionState({
    this.code,
    this.message,
  });
}
