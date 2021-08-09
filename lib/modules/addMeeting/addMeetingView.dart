import 'dart:convert';
import 'dart:developer';

import 'package:demo_b/models/meeting/meeting_model.dart';
import 'package:demo_b/repositories/meeting/meeting_res.dart';
import 'package:demo_b/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../constants/appColor.dart';
import '../../core/locales/i18nKey.dart';
import '../../core/routes/routeName.dart';
import '../../utils/screenUtil.dart';
import '../../widgets/appAppBar.dart';
import '../../widgets/appButton.dart';
import '../../widgets/appInput.dart';
import '../../widgets/appSpinner.dart';
import '../../widgets/orderRoomTile.dart';
import '../../widgets/selectRepeatTile.dart';
import '../../widgets/selectRoomTile.dart';
import '../base/baseView.dart';
import 'addMeetingModel.dart';
import 'selectParticipant/selectParticipantView.dart';
import 'selectRepeat/selectRepeatView.dart';
import 'selectRoom/selectRoomView.dart';

class AddMeetingView extends StatefulWidget {
  const AddMeetingView({Key key, this.initModel}) : super(key: key);

  final MeetingModel initModel;

  @override
  _AddMeetingViewState createState() => _AddMeetingViewState();
}

class _AddMeetingViewState extends State<AddMeetingView> {
  final txtNote = TextEditingController();
  final txtTitle = TextEditingController();

  @override
  void dispose() {
    txtTitle.dispose();
    txtNote.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.initModel != null) {
      txtTitle.text = widget.initModel.name;
      txtNote.text = widget.initModel.note;
    }
    super.initState();
  }

  String _checkValid(AddMeetingModel model) {
    if (txtTitle.text.isEmpty) {
      return 'Vui lòng nhập tiêu đề';
    } else if (model.model.room == null) {
      return 'Vui lòng chọn phòng họp';
    } else if (model.model.startTime == null) {
      return 'Vui lòng chọn bắt đầu';
    } else if (model.model.endTime == null) {
      return 'Vui lòng chọn kết thúc';
    } else if (model.model.repeat == null) {
      return 'Vui lòng chọn lặp lại';
    } else if ((model?.model?.members?.length ?? 0) == 0) {
      return 'Vui lòng chọn người tham gia';
    }
    return null;
  }

  Widget _buildView(BuildContext context, AddMeetingModel model) {
    return Container(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: AppInput(
                        hintText: '${ScreenUtil.t(I18nKey.enterTitle)}',
                        controller: txtTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Container(
                        color: AppColor.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  'Cài đặt sẵn',
                                  style: TextStyle(color: AppColor.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 12, left: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 0),
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: model.dropdownValue,
                                            items: model.dropdownList
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              model.onDropdownChanged(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _buildTile(context, model, index),
                      itemCount: model.items.length,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: AppInput(
                        hintText: '${ScreenUtil.t(I18nKey.note)}',
                        multiline: 6,
                        controller: txtNote,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    contained: true,
                    title: '${ScreenUtil.t(I18nKey.cancel)}',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    contained: true,
                    primary: true,
                    title: '${ScreenUtil.t(I18nKey.orderRoom)}',
                    onPressed: () async {
                      model.model.name = txtTitle.text;
                      model.model.note = txtNote.text;
                      final res = _checkValid(model);
                      if (res == null) {
                        //handle create new meeting
                        final jsonData = model.model.toJson();
                        jsonData.removeWhere((key, value) => value == null);
                        debugPrint('Model to add: ${jsonEncode(jsonData)}');
                        bool res;
                        if (widget.initModel == null) {
                          res =
                              await MeetingRes().createNewMeeting(model.model);
                        } else {
                          res =
                              await MeetingRes().updateNewMeeting(model.model);
                        }

                        if (res ?? false) {
                          Toast.success(message: 'Thành công!');
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                        } else {
                          Toast.error(message: 'Thất bại!');
                        }
                      } else {
                        Toast.warn(message: res);
                      }
                    },
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, AddMeetingModel model, int index) {
    return OrderRoomTile(
      title: model.items[index].title,
      content: model.data[index],
      onPressed: navigate(context, index, model),
    );
  }

  Function navigate(
    BuildContext context,
    int index,
    AddMeetingModel model,
  ) {
    switch (index) {
      case 0:
        return () async {
          // Navigator.of(context).pushNamed(RouteName.selectRoom);
          final res = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SelectRoomView(
                initRoom: widget.initModel?.room as String,
              ),
            ),
          );
          log('res = $res');
          if (res != null) {
            final room = res as SelectRoomItem;
            model.updateRoom(room.name);
            model.model.room = room.id;
          }
        };
      case 1:
        return () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            minTime: DateTime.now(),
            onChanged: (date) {
              print('change $date');
            },
            onConfirm: (date) {
              print('startDate $date');
              model.updateStart(date);
            },
            currentTime: DateTime.now(),
            locale: LocaleType.vi,
          );
        };
      case 2:
        return () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            minTime: DateTime.now(),
            onChanged: (date) {
              print('change $date');
            },
            onConfirm: (date) {
              print('endDate  $date');
              model.updateEnd(date);
            },
            currentTime: DateTime.now(),
            locale: LocaleType.vi,
          );
        };
      case 3:
        return () async {
          // Navigator.of(context).pushNamed(RouteName.selectRepeat);
          final res = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SelectRepeatView(init: widget.initModel?.repeat??0,),
            ),
          );
          log('res = $res');
          if (res != null) {
            final repeat = res as SelectRepeatItem;
            model.updaterepeat(ScreenUtil.t(repeat.title));
            model.model.repeat = repeat.value;
          }
        };
      case 4:
        return () async {
          // Navigator.of(context).pushNamed(RouteName.selectParticipant);
          final res = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SelectParticipantView(
                lsSelected: widget.initModel?.members ?? [],
              ),
            ),
          );
          log('res = $res');
          if (res != null) {
            model.model.members = res;
            model.updateMember(model.model.members.length);
          }
        };
      default:
        return () {
          Navigator.of(context).pushNamed(RouteName.selectRoom);
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<AddMeetingModel>(
      model: AddMeetingModel(context)..init(initModel: widget.initModel),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                centerTitle: true,
                title: widget.initModel == null
                    ? '${ScreenUtil.t(I18nKey.orderRoom)}'
                    : 'Chỉnh sửa',
                leading: InkWell(
                  child: Icon(
                    Icons.close,
                    color: AppColor.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: _buildView(context, model)),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }
}
