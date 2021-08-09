import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/models/control/device.dart';
import 'package:demo_b/models/control/room.dart';
import 'package:demo_b/modules/adminControl/deviceListControl/appBottomSheet.dart';
import 'package:demo_b/modules/adminControl/deviceListControl/deviceListControlModel.dart';
import 'package:demo_b/modules/base/baseView.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:demo_b/widgets/appAppBar.dart';
import 'package:demo_b/widgets/appSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceListControlView extends StatefulWidget {
  final Room args;

  DeviceListControlView(this.args);

  @override
  _DeviceListControlViewState createState() => _DeviceListControlViewState();
}

class _DeviceListControlViewState extends State<DeviceListControlView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<DeviceListControlModel>(
      model: DeviceListControlModel(),
      onModelReady: (model) async {
        await model.getDeviceList(widget.args.id);
      },
      builder: (context, model, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Scaffold(
              appBar: AppAppBar(
                allowBack: true,
                title: '${widget.args.name}',
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(
                        widget.args.status == 'Active'
                            ? Icons.lock_open
                            : Icons.lock,
                        color: AppColor.black,
                      ),
                      onPressed: () {})
                ],
              ),
              body: _buildView(context, model),
            ),
            model.loading ? AppSpinner() : Container()
          ],
        );
      },
    );
  }

  Widget _buildView(BuildContext context, DeviceListControlModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ScreenUtil.width,
          color: AppColor.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Thiết bị khả dụng',
              style: TextStyle(color: AppColor.grey),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  buildDeviceItem(model, model.list[index]),
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                  ),
              itemCount: model.list.length),
        ),
      ],
    );
  }

  Future<void> showAlertDialog(DeviceListControlModel model, Device device,
      {int value}) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Thiết bị đang sử dụng!'),
        content: Text(
            'Bạn có chắc chắn muốn tắt ${device.deviceName} hiện đang được sử dụng?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Huỷ bỏ',
              style: TextStyle(color: AppColor.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'Xác nhận',
              style: TextStyle(color: AppColor.primary),
            ),
            onPressed: () async {
              await model.updateDevice(device.id, isOn: false, value: value);
              await model.getDeviceList(widget.args.id);
              Navigator.of(context).pop();
              if (value != null) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDeviceItem(DeviceListControlModel model, Device device) {
    switch (device.deviceType) {
      case 0:
        return SwitchListTile(
          tileColor: AppColor.white,
          title: Text('${device.deviceName}'),
          value: device.isOn,
          onChanged: (value) async {
            if (!value) {
              await showAlertDialog(model, device);
            } else {
              await model.updateDevice(device.id, isOn: true);
            }
            await model.getDeviceList(widget.args.id);
          },
        );
      case 1:
        return ListTile(
          tileColor: AppColor.white,
          title: Text('${device.deviceName}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(device.isOn ? 'On' : 'Off'),
              ),
              Icon(Icons.navigate_next),
            ],
          ),
          onTap: () {
            showBottomSheet(model, device);
          },
        );
      default:
        return Container();
    }
  }

  Future<void> showBottomSheet(
      DeviceListControlModel model, Device device) async {
    return showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isDismissible: false,
        builder: (BuildContext context) =>
            AppBottomSheet(device, (isOn, value) async {
              if (device.isOn) {
                if (!isOn) {
                  await showAlertDialog(model, device, value: value);
                } else {
                  await model.updateDevice(device.id, isOn: true, value: value);
                  await model.getDeviceList(widget.args.id);
                  Navigator.of(context).pop();
                }
              } else {
                await model.updateDevice(device.id, isOn: isOn, value: value);
                await model.getDeviceList(widget.args.id);
                Navigator.of(context).pop();
              }
            }));
  }
}
