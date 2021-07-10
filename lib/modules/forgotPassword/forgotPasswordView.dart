import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/viewModels/validationModel.dart';
import 'package:demo_b/modules/base/baseView2.dart';
import 'package:demo_b/modules/forgotPassword/forgotPasswordModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appButton.dart';
import 'package:demo_b/widgets/appInput.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView2<ForgotPasswordModel, ValidationModel>(
        model1: ForgotPasswordModel(),
        model2: ValidationModel(),
        builder: (context, forgotPasswordModel, validationModel, _) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Scaffold(
                body: _buildView(context, forgotPasswordModel, validationModel),
              ),
              forgotPasswordModel.loading ? AppSpinner() : Container()
            ],
          );
        });
  }

  Future<void> onForgotPassword(ForgotPasswordModel forgotPasswordModel,
      ValidationModel validationModel) async {
    if (validationModel.isValidForgotPassword(
      forgotPasswordModel.email,
    )) {
      await forgotPasswordModel.forgotPassword();
    }
  }

  Widget _buildView(
      BuildContext context,
      ForgotPasswordModel forgotPasswordModel,
      ValidationModel validationModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, ScreenUtil.height * 0.15, 30, 0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppInput(
                  outlined: true,
                  hintText: '${ScreenUtil.t(I18nKey.email)}',
                  errorText: validationModel.email.error,
                  controller:
                      TextEditingController(text: validationModel.email.value),
                  onChanged: (String value) {
                    forgotPasswordModel.email = value.trim();
                    validationModel.onEmailChanged(value.trim());
                  },
                ),
                SizedBox(
                  height: ScreenUtil.height / 12,
                ),
                AppButton(
                    full: true,
                    contained: true,
                    primary: true,
                    title: '${ScreenUtil.t(I18nKey.forgotPassword)}',
                    onPressed: () =>
                        onForgotPassword(forgotPasswordModel, validationModel)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
