import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/room/room_model.dart';
import '../../repositories/room/room_res.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitialState());

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    try {
      if (event is RoomFetchEvent) {
        yield RoomWaitingState();
        final res = await RoomRes().getAllRoom();
        if (res != null) {
          res.data.sort((a, b) => a.name.compareTo(b.name));
          yield RoomFetchDoneState(res.data);
        } else {
          yield RoomFetchFailState(message: 'Lỗi không xác định');
        }
      }
    } catch (err) {
      log(err.toString());
      yield RoomExceptionState(message: 'Lỗi không xác định');
    }
  }
}
