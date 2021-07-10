import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/widgets/selectRepeatTile.dart';

class SelectRepeatModel extends BaseModel {
  List<SelectRepeatItem> items = [
    SelectRepeatItem(title: I18nKey.never, selected: true),
    SelectRepeatItem(title: I18nKey.everyDay, selected: false),
    SelectRepeatItem(title: I18nKey.everyWeek, selected: false),
    SelectRepeatItem(title: I18nKey.everyMonth, selected: false),
    SelectRepeatItem(title: I18nKey.everyYear, selected: false),
  ];

  void onChangedSelectItem(int index, bool value) {
    for (int i = 0; i < items.length; i++) {
      if (i == index) {
        items[i].selected = value;
      } else {
        items[i].selected = false;
      }
    }
    notifyListeners();
  }
}
