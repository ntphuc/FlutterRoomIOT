part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationWaitingState extends NotificationState {}

class NotificationFetchDoneState extends NotificationState {
  final NotificationApi data;

  NotificationFetchDoneState(this.data);
}

class NotificationFetchFailState extends NotificationState {
  final String code;
  final String message;

  NotificationFetchFailState({
    this.code,
    this.message,
  });
}

class NotificationExceptionState extends NotificationState {
  final String code;
  final String message;

  NotificationExceptionState({
    this.code,
    this.message,
  });
}
