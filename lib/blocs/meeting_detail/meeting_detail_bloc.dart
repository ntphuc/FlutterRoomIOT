import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:demo_b/repositories/meeting/meeting_res.dart';
import 'package:meta/meta.dart';

part 'meeting_detail_event.dart';
part 'meeting_detail_state.dart';

class MeetingDetailBloc extends Bloc<MeetingDetailEvent, MeetingDetailState> {
  MeetingDetailBloc() : super(MeetingDetailInitialState());

  @override
  Stream<MeetingDetailState> mapEventToState(
    MeetingDetailEvent event,
  ) async* {
    try {
      if (event is MeetingDetailFetchEvent) {
        yield MeetingDetailWaitingState();
        final res = await MeetingRes().getMeetingDetail(event.meetingId);
        if (res != null) {
          yield MeetingDetailFetchDoneState(res);
        } else {
          yield MeetingDetailFetchFailState(message: 'Lỗi tải dữ liệu từ máy chủ');
        }
      }
    } catch (err) {
      log(err.toString());
      yield MeetingDetailExceptionState(message: 'Lỗi không xác định');
    }
  }
}
