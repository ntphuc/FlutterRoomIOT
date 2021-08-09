import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/models/control/room.dart';
import 'package:demo_b/modules/adminControl/roomListControl/roomListControlModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/material.dart';

class RoomListControlView extends StatefulWidget {
  @override
  _RoomListControlViewState createState() => _RoomListControlViewState();
}

class _RoomListControlViewState extends State<RoomListControlView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BaseView<RoomListControlModel>(
      model: RoomListControlModel(),
      onModelReady: (model) async {
        await model.getRoomList();
      },
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                allowBack: true,
                title: 'Admin Control',
                centerTitle: true,
              ),
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, RoomListControlModel model) {
    return ListView.separated(
        itemBuilder: (context, index) => buildRoomItem(model.list[index]),
        separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 1,
            ),
        itemCount: model.list.length);
  }

  Widget buildRoomItem(Room item) => ListTile(
        tileColor: AppColor.white,
        leading: Icon(item.status == 'Active' ? Icons.lock_open : Icons.lock),
        title: Text('${item.name}'),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteName.deviceListControl, arguments: item);
        },
      );
}
