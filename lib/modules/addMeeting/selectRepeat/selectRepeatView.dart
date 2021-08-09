import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/addMeeting/selectRepeat/selectRepeatModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/selectRepeatTile.dart';
import 'package:flutter/material.dart';

class SelectRepeatView extends StatefulWidget {
  final int init;

  const SelectRepeatView({Key key, this.init}) : super(key: key);
  @override
  _SelectRepeatViewState createState() => _SelectRepeatViewState();
}

class _SelectRepeatViewState extends State<SelectRepeatView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SelectRepeatModel>(
      model: SelectRepeatModel()..init(widget?.init ?? 0),
      builder: (context, model, _) {
        return WillPopScope(
          onWillPop: () async {
            final ls =
                model.items.where((element) => element.selected).toList();
            final item = ls.length == 0 ? model.items.first : ls.first;
            Navigator.of(context).pop(item);
            return Future.value(false);
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Scaffold(
                appBar: AppAppBar(
                  centerTitle: true,
                  title: '${ScreenUtil.t(I18nKey.repeat)}',
                  allowBack: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    color: Colors.black,
                    onPressed: () {
                      final ls = model.items
                          .where((element) => element.selected)
                          .toList();
                      final item =
                          ls.length == 0 ? model.items.first : ls.first;
                      Navigator.of(context).pop(item);
                    },
                  ),
                ),
                body: _buildView(context, model),
              ),
              model.loading ? AppSpinner() : Container()
            ],
          ),
        );
      },
    );
  }

  Widget _buildView(BuildContext context, SelectRepeatModel model) {
    return Container(
      color: AppColor.white,
      child: ListView.builder(
        itemBuilder: (context, index) => _buildTile(model, index),
        itemCount: model.items.length,
      ),
    );
  }

  Widget _buildTile(SelectRepeatModel model, int index) {
    return SelectRepeatTile(
      title: model.items[index].title,
      selected: model.items[index].selected,
      onChanged: (value) {
        model.onChangedSelectItem(index, value);
      },
    );
  }
}
