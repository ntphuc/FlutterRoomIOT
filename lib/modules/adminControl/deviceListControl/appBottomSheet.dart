import 'package:demo_b/constants/appColor.dart';
import 'package:demo_b/models/control/device.dart';
import 'package:demo_b/utils/screenUtil.dart';
import 'package:flutter/material.dart';

class AppBottomSheet extends StatefulWidget {
  final Device device;
  final Function(bool, int) onConfirm;

  AppBottomSheet(this.device, this.onConfirm);

  @override
  _AppBottomSheetState createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  bool currentIsOn;
  int currentValue;

  @override
  void initState() {
    super.initState();
    currentIsOn = widget.device.isOn;
    currentValue = widget.device.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.height / 2,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColor.black),
                    )),
                Text(
                  '${widget.device.deviceName}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  width: 60,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'On/Off',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Switch(
                          value: currentIsOn,
                          onChanged: (value) async {
                            setState(() {
                              currentIsOn = value;
                            });
                          })
                    ],
                  ),
                  Text(
                    'Volume: $currentValue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.device.minValue}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Expanded(
                        child: Slider(
                          value: currentValue.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              currentValue = value.toInt();
                            });
                          },
                          min: widget.device.minValue.toDouble(),
                          max: widget.device.maxValue.toDouble(),
                        ),
                      ),
                      Text(
                        '${widget.device.maxValue}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: ScreenUtil.width - 32,
                      child: ElevatedButton(
                        child: Text('Cập nhật'),
                        onPressed: () {
                          widget.onConfirm(currentIsOn, currentValue);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
