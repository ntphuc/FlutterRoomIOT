import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/addMeeting/selectRoom/selectRoomModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/selectRoomTile.dart';
import 'package:flutter/material.dart';

class SelectRoomView extends StatefulWidget {
  @override
  _SelectRoomViewState createState() => _SelectRoomViewState();
}

class _SelectRoomViewState extends State<SelectRoomView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SelectRoomModel>(
      model: SelectRoomModel(),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                centerTitle: true,
                title: '${ScreenUtil.t(I18nKey.meetingRoom)}',
                allowBack: true,
              ),
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, SelectRoomModel model) {
    return Container(
      color: AppColor.white,
      child: ListView.builder(
        itemBuilder: (context, index) => _buildTile(model, index),
        itemCount: model.items.length,
      ),
    );
  }

  Widget _buildTile(SelectRoomModel model, int index) {
    return SelectRoomTile(
      name: model.items[index].name,
      description: model.items[index].description,
      selected: model.items[index].selected,
      onChanged: (value) {
        model.onChangedSelectItem(index, value);
      },
    );
  }
}
