import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/addMeeting/selectParticipant/selectParticipantModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appInput.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/selectParticipantTitle.dart';
import 'package:flutter/material.dart';

class SelectParticipantView extends StatefulWidget {
  @override
  _SelectParticipantViewState createState() => _SelectParticipantViewState();
}

class _SelectParticipantViewState extends State<SelectParticipantView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SelectParticipantModel>(
      model: SelectParticipantModel(),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                centerTitle: true,
                title: '${ScreenUtil.t(I18nKey.participant)}',
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

  Widget _buildView(BuildContext context, SelectParticipantModel model) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: AppInput(
              outlined: true,
              hintText: '${ScreenUtil.t(I18nKey.search)}',
              search: true,
              onSearch: () {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => _buildTile(model, index),
              itemCount: model.items.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(SelectParticipantModel model, int index) {
    return SelectParticipantTile(
      title: model.items[index].title,
      avatar: model.items[index].avatar,
      selected: model.items[index].selected,
      onChanged: (value) {
        model.onChangedSelectItem(index, value);
      },
    );
  }
}
