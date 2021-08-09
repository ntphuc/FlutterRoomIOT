part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class MeetingWaitingState extends UserState {}

class UserFetchDoneState extends UserState {
  final List<UserModel> lsData;

  UserFetchDoneState(this.lsData);
}

class UserFetchFailState extends UserState {
  final String code;
  final String message;

  UserFetchFailState({
    this.code,
    this.message,
  });
}

class UserExceptionState extends UserState {
  final String code;
  final String message;

  UserExceptionState({
    this.code,
    this.message,
  });
}
