import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/widgets/optionTile.dart';
import 'package:flutter/material.dart';

class SettingModel extends BaseModel {
  List<String> languages = <String>[I18nKey.english, I18nKey.vietnamese];

  List<OptionItem> items = [
    OptionItem(iconData: Icons.star, title: I18nKey.rate),
    OptionItem(iconData: Icons.feedback, title: I18nKey.feedback),
    OptionItem(iconData: Icons.info, title: I18nKey.info),
    OptionItem(
      iconData: Icons.exit_to_app,
      title: I18nKey.signOut,
    )
  ];
}
