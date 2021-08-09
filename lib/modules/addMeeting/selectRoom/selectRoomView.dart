import 'package:demo_b/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/room/room_bloc.dart';
import '../../../constants/appColor.dart';
import '../../../core/locales/i18nKey.dart';
import '../../../utils/screenUtil.dart';
import '../../../widgets/appAppBar.dart';
import '../../../widgets/appSpinner.dart';
import '../../../widgets/selectRoomTile.dart';
import '../../base/baseView.dart';
import 'selectRoomModel.dart';

class SelectRoomView extends StatefulWidget {
  final String initRoom;

  const SelectRoomView({Key key, this.initRoom}) : super(key: key);
  @override
  _SelectRoomViewState createState() => _SelectRoomViewState();
}

class _SelectRoomViewState extends State<SelectRoomView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (context) => RoomBloc()..add(RoomFetchEvent()),
      child: BaseView<SelectRoomModel>(
        model: SelectRoomModel(),
        builder: (context, model, _) {
          return WillPopScope(
            onWillPop: () {
              final ls = model.items?.where((e) => e.selected)?.toList();
              Navigator.of(context).pop(ls?.length == 0 ? null : ls.first);
              return Future.value(false);
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Scaffold(
                  appBar: AppAppBar(
                    centerTitle: true,
                    title: '${ScreenUtil.t(I18nKey.meetingRoom)}',
                    allowBack: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.black,
                      onPressed: () {
                        final ls =
                            model.items?.where((e) => e.selected)?.toList();
                        Navigator.of(context)
                            .pop(ls?.length == 0 ? null : ls.first);
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

  Widget _buildView(BuildContext context, SelectRoomModel model) {
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomFetchDoneState) {
          model.items.clear();
          model.items.addAll(
            state.lsData
                .map(
                  (e) => SelectRoomItem(
                    id: e.id,
                    name: e.name,
                    description: e.area,
                    selected: e.id == widget?.initRoom,
                  ),
                )
                .toList(),
          );
        }
        if (state is RoomFetchFailState) {
          Toast.error(message: state.message ?? '');
        } else if (state is RoomExceptionState) {
          Toast.error(message: state.message ?? '');
        }
      },
      child: Container(
        color: AppColor.white,
        child: BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: (state is RoomFetchDoneState)
                  ? ListView.builder(
                      itemBuilder: (context, index) => _buildTile(model, index),
                      itemCount: model.items.length,
                    )
                  : (state is RoomFetchFailState || state is RoomExceptionState)
                      ? InkWell(
                          onTap: () {
                            BlocProvider.of<RoomBloc>(context)
                                .add(RoomFetchEvent());
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
