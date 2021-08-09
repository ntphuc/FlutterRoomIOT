import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/widgets/selectRepeatTile.dart';

class SelectRepeatModel extends BaseModel {
  List<SelectRepeatItem> items = [
    SelectRepeatItem(
      title: I18nKey.never,
      selected: false,
      value: 0,
    ),
    SelectRepeatItem(
      title: I18nKey.everyDay,
      selected: false,
      value: 1,
    ),
    SelectRepeatItem(
      title: I18nKey.everyWeek,
      selected: false,
      value: 2,
    ),
    SelectRepeatItem(
      title: I18nKey.everyMonth,
      selected: false,
      value: 3,
    ),
    SelectRepeatItem(
      title: I18nKey.everyYear,
      selected: false,
      value: 4,
    ),
  ];

  void init(int init) {
    items[init].selected = true;
    notifyListeners();
  }

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
