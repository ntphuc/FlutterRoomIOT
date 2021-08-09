import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:demo_b/repositories/meeting/meeting_res.dart';
import 'package:meta/meta.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitialState());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    try {
      if (event is MeetingFetchEvent) {
        yield MeetingWaitingState();
        final res = await MeetingRes().getAllMeetings(
          event.roomId,
          event.startTime,
          event.endTime,
        );
        if (res != null) {
          yield MeetingFetchDoneState(res.meetings);
        } else {
          yield MeetingFetchFailState(message: 'Lỗi không xác định');
        }
      }
    } catch (err) {
      log(err.toString());
      yield MeetingExceptionState(message: 'Lỗi không xác định');
    }
  }
}
