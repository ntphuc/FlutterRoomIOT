import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:demo_b/models/user/user_model.dart';
import 'package:demo_b/repositories/user/user_res.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if (event is UserFetchEvent) {
        yield MeetingWaitingState();
        final res = await UserRes().getAllUser();
        if (res != null) {
          yield UserFetchDoneState(res.data);
        } else {
          yield UserFetchFailState(message: 'Lỗi không xác định');
        }
      }
    } catch (err) {
      log(err.toString());
      yield UserExceptionState(message: 'Lỗi không xác định');
    }
  }
}
