import 'package:demo_b/constants/appStyle.dart';
import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/core/validations/validationModel.dart';
import 'package:demo_b/modules/base/baseView2.dart';
import 'package:demo_b/modules/signIn/signInModel.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appButton.dart';
import 'package:demo_b/widgets/appInput.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:demo_b/widgets/logo.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController();
  // TextEditingController(text: kDebugMode ? 'duongngoanh@gmail.com' : '');
  TextEditingController passwordController = TextEditingController();
  // TextEditingController(text: kDebugMode ? 'fijZif-xeqcab-5cypfa' : '');

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView2<SignInModel, ValidationModel>(
        model1: SignInModel(context),
        model2: ValidationModel(),
        builder: (context, signInModel, validationModel, _) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                body: _buildView(context, signInModel, validationModel),
              ),
              signInModel.loading ? AppSpinner() : Container()
            ],
          );
        });
  }

  Future<void> onSignIn(
      SignInModel signInModel, ValidationModel validationModel) async {
    if (validationModel.isValidSignIn(
        signInModel.email, signInModel.password)) {
      await signInModel.signIn();
    }
  }

  Widget _buildView(BuildContext context, SignInModel signInModel,
      ValidationModel validationModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, ScreenUtil.height * 0.15, 30, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Logo(),
            SizedBox(
              height: ScreenUtil.height / 24,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${ScreenUtil.t(I18nKey.signInTitle1)}',
                style: AppStyle.h2,
              ),
            ),
            Text(
              '${ScreenUtil.t(I18nKey.signInTitle2)}',
              style: AppStyle.title2,
            ),
            SizedBox(
              height: ScreenUtil.height / 24,
            ),
            AppInput(
              outlined: true,
              hintText: '${ScreenUtil.t(I18nKey.email)}',
              errorText: validationModel.email.error,
              controller: emailController
                ..text = signInModel.email
                ..selection = TextSelection.collapsed(
                    offset: emailController.text.length),
              onChanged: (String value) {
                signInModel.email = value.trim();
                validationModel.onEmailChanged(value.trim());
              },
            ),
            SizedBox(
              height: ScreenUtil.height / 48,
            ),
            AppInput(
              outlined: true,
              obscureText: true,
              hintText: '${ScreenUtil.t(I18nKey.password)}',
              errorText: validationModel.password.error,
              controller: passwordController
                ..text = signInModel.password
                ..selection = TextSelection.collapsed(
                    offset: passwordController.text.length),
              onChanged: (String value) {
                signInModel.password = value.trim();
                validationModel.onPasswordChanged(value.trim());
                passwordController
                  ..selection = TextSelection.collapsed(
                      offset: passwordController.text.length);
              },
            ),
            SizedBox(
              height: ScreenUtil.height / 24,
            ),
            AppButton(
                full: true,
                contained: true,
                primary: true,
                title: '${ScreenUtil.t(I18nKey.signIn)}',
                onPressed: () => onSignIn(signInModel, validationModel)),
            SizedBox(
              height: ScreenUtil.height / 36,
            ),
            AppButton(
              title: '${ScreenUtil.t(I18nKey.forgotPassword)}?',
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteName.forgotPassword),
            ),
          ],
        ),
      ),
    );
  }
}
