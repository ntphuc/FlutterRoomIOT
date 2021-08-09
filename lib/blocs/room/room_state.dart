part of 'room_bloc.dart';

@immutable
abstract class RoomState {}

class RoomInitialState extends RoomState {}

class RoomWaitingState extends RoomState {}

class RoomFetchDoneState extends RoomState {
  final List<RoomModel> lsData;

  RoomFetchDoneState(this.lsData);
}

class RoomFetchFailState extends RoomState {
  final String code;
  final String message;

  RoomFetchFailState({
    this.code,
    this.message,
  });
}

class RoomExceptionState extends RoomState {
  final String code;
  final String message;

  RoomExceptionState({
    this.code,
    this.message,
  });
}
