part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class NotificationFetchEvent extends NotificationEvent {
  final int page;

  NotificationFetchEvent({
    @required this.page,
  });
}
