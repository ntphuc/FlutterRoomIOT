import 'package:demo_b/models/control/device.dart';
import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/services/controlService.dart';
import 'package:demo_b/utils/toast.dart';

class DeviceListControlModel extends BaseModel {
  ControlService _controlService = ControlService.instance();
  List<Device> list = [];

  Future<void> getDeviceList(String roomId) async {
    setLoading(true);
    try {
      List<Device> devices = (await _controlService.getDeviceList(roomId)).data;
      list = devices;
      notifyListeners();
    } catch (error) {
      Toast.error(message: error.message);
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateDevice(String deviceId, {bool isOn, int value}) async {
    setLoading(true);
    try {
      await _controlService.updateDevice(deviceId, isOn: isOn, value: value);
    } catch (error) {
      Toast.error(message: error.message);
    } finally {
      setLoading(false);
    }
  }
}
