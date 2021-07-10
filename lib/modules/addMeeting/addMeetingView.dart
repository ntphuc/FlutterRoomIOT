import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/addMeeting/addMeetingModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appButton.dart';
import 'package:demo_b/widgets/appInput.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/orderRoomTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddMeetingView extends StatefulWidget {
  @override
  _AddMeetingViewState createState() => _AddMeetingViewState();
}

class _AddMeetingViewState extends State<AddMeetingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<AddMeetingModel>(
      model: AddMeetingModel(context),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                centerTitle: true,
                title: '${ScreenUtil.t(I18nKey.orderRoom)}',
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
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, AddMeetingModel model) {
    return Container(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: AppInput(
                      hintText: '${ScreenUtil.t(I18nKey.enterTitle)}',
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
                    ),
                  ),
                ],
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
                    onPressed: () {},
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
      onPressed: navigate(context, index),
    );
  }

  Function() navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        return () {
          Navigator.of(context).pushNamed(RouteName.selectRoom);
        };
      case 1:
        return () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime.now(), onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.vi);
        };
      case 2:
        return () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime.now(), onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.vi);
        };
      case 3:
        return () {
          Navigator.of(context).pushNamed(RouteName.selectRepeat);
        };
      case 4:
        return () {
          Navigator.of(context).pushNamed(RouteName.selectParticipant);
        };
      default:
        return () {
          Navigator.of(context).pushNamed(RouteName.selectRoom);
        };
    }
  }
}
