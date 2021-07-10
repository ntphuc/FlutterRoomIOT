import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/modules/setting/settingModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/optionTile.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<SettingModel>(
      model: SettingModel(),
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, SettingModel model) {
    // ThemeModel themeModel = Provider.of<ThemeModel>(context);
    // LocaleModel localeModel = Provider.of<LocaleModel>(context);
    return Container(
      color: AppColor.white,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.width,
            height: ScreenUtil.height / 3.5,
            color: AppColor.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    'Ngo Anh Duong',
                    style: AppStyle.h2White,
                  ),
                ),
                Text(
                  'ngoanhduong@gmail.com',
                  style: AppStyle.contentWhite,
                ),
              ],
            ),
          ),
          // SwitchListTile(
          //   title: Text('${ScreenUtil.t(I18nKey.darkMode)}'),
          //   value: themeModel.appTheme == AppTheme.Dark,
          //   onChanged: (bool value) {
          //     Provider.of<ThemeModel>(context, listen: false)
          //         .toggleTheme(value ? AppTheme.Dark : AppTheme.Light);
          //   },
          // ),
          // AppExpansion.builder(
          //   header: Text('${ScreenUtil.t(I18nKey.language)}'),
          //   itemCount: supportedLocales.length,
          //   itemBuilder: (int index) {
          //     return RadioListTile<AppLocale>(
          //       title: Text('${ScreenUtil.t(model.languages[index])}'),
          //       value: appLocales[index],
          //       groupValue: localeModel.appLocale,
          //       onChanged: (AppLocale value) {
          //         Provider.of<LocaleModel>(context, listen: false)
          //             .toggleLocale(value);
          //       },
          //     );
          //   },
          // ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.items.length,
            itemBuilder: (context, index) => _buildTile(context, model, index),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, SettingModel model, int index) {
    return OptionTile(
      iconData: model.items[index].iconData,
      title: model.items[index].title,
      onPressed: navigate(context, index),
    );
  }

  Function() navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        return () {};
      case 1:
        return () {};
      case 2:
        return () {};
      case 3:
        return () {
          Navigator.of(context).pushReplacementNamed(RouteName.signIn);
        };
      default:
        return () {};
    }
  }
}
