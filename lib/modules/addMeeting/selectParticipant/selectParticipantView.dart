import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../constants/appColor.dart';
import '../../../core/locales/i18nKey.dart';
import '../../../utils/screenUtil.dart';
import '../../../utils/toast.dart';
import '../../../widgets/appAppBar.dart';
import '../../../widgets/appInput.dart';
import '../../../widgets/appSpinner.dart';
import '../../../widgets/selectParticipantTitle.dart';
import '../../base/baseView.dart';
import 'selectParticipantModel.dart';

class SelectParticipantView extends StatefulWidget {
  final List<String> lsSelected;

  const SelectParticipantView({
    Key key,
    this.lsSelected = const [],
  }) : super(key: key);
  @override
  _SelectParticipantViewState createState() => _SelectParticipantViewState();
}

class _SelectParticipantViewState extends State<SelectParticipantView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (context) => UserBloc()..add(UserFetchEvent()),
      child: BaseView<SelectParticipantModel>(
        model: SelectParticipantModel(),
        builder: (context, model, _) {
          return WillPopScope(
            onWillPop: () {
              Navigator.of(context).pop(model.items
                  .where((e) => e.selected)
                  .toList()
                  .map((e) => e.id)
                  .toList());
              return Future.value(false);
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Scaffold(
                  appBar: AppAppBar(
                    centerTitle: true,
                    title: '${ScreenUtil.t(I18nKey.participant)}',
                    allowBack: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop(model.items
                            .where((e) => e.selected)
                            .toList()
                            .map((e) => e.id)
                            .toList());
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
      ),
    );
  }

  Widget _buildView(BuildContext context, SelectParticipantModel model) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFetchDoneState) {
          model.items.clear();
          model.items.addAll(state.lsData
              .map((e) => SelectParticipantItem(
                    id: e.id,
                    title: e.email,
                    selected: widget.lsSelected.contains(e.id),
                  ))
              .toList());
        }
        if (state is UserFetchFailState) {
          Toast.error(message: state.message ?? '');
        } else if (state is UserExceptionState) {
          Toast.error(message: state.message ?? '');
        }
      },
      child: Container(
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
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: (state is UserFetchDoneState)
                        ? ListView.builder(
                            itemBuilder: (context, index) =>
                                _buildTile(model, index),
                            itemCount: model.items.length,
                          )
                        : (state is UserFetchFailState ||
                                state is UserExceptionState)
                            ? InkWell(
                                onTap: () {
                                  BlocProvider.of<UserBloc>(context)
                                      .add(UserFetchEvent());
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              )
                            : Center(
                                child: CupertinoActivityIndicator(),
                              ),
                  );
                },
              ),
            ),
          ],
        ),
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
