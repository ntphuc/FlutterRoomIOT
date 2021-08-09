import 'package:demo_b/configs/endpoint.ts.dart';
import 'package:demo_b/constants/key_headers.dart';
import 'package:demo_b/constants/key_prefs.dart';
import 'package:demo_b/models/control/get_device.dart';
import 'package:demo_b/models/control/get_room.dart';
import 'package:demo_b/utils/asyncStorage.dart';
import 'package:dio/dio.dart';

class ControlService {
  Dio dio;

  ControlService._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: Endpoint.BASE_URL, connectTimeout: 6000, receiveTimeout: 6000);
    dio = Dio(options);
  }

  static final ControlService _instance = ControlService._internal();

  factory ControlService.instance() => _instance;

  Future<GetRoomRes> getRoomList() async {
    String token = await AsyncStorage.get(KeyPrefs.ACCESS_TOKEN);
    dio.options.headers[KeyHeaders.AUTH_TOKEN] = token;
    Response response = await dio.get(
      Endpoint.ROOMS,
    );
    GetRoomRes res = GetRoomRes.fromJson(response.data);
    return res;
  }

  Future<GetDeviceRes> getDeviceList(String roomId) async {
    String token = await AsyncStorage.get(KeyPrefs.ACCESS_TOKEN);
    dio.options.headers[KeyHeaders.AUTH_TOKEN] = token;
    Response response = await dio.get(
      '${Endpoint.DEVICES}$roomId',
    );
    GetDeviceRes res = GetDeviceRes.fromJson(response.data);
    return res;
  }

  Future<bool> updateDevice(String deviceId, {bool isOn, int value}) async {
    String token = await AsyncStorage.get(KeyPrefs.ACCESS_TOKEN);
    dio.options.headers[KeyHeaders.AUTH_TOKEN] = token;
    Response response = await dio.put('${Endpoint.DEVICE_DATA}$deviceId',
        data: {'is_on': isOn, 'current_value': value});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
