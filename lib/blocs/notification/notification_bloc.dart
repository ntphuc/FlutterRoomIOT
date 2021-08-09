import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/notification/notification_api.dart';
import '../../repositories/notificaiton/notification_res.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitialState());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    try {
      if (event is NotificationFetchEvent) {
        yield NotificationWaitingState();
        final res = await NotificationRes().getNotification(event.page);
        if (res != null) {
          yield NotificationFetchDoneState(res);
        } else {
          yield NotificationFetchFailState(message: 'Lỗi không xác định');
        }
      }
    } catch (err) {
      log(err.toString());
      yield NotificationExceptionState(message: 'Lỗi không xác định');
    }
  }
}
