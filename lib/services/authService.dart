import 'package:demo_b/configs/endpoint.ts.dart';
import 'package:demo_b/constants/key_headers.dart';
import 'package:demo_b/models/reqres/forgotPassword.dart';
import 'package:demo_b/models/reqres/signIn.dart';
import 'package:demo_b/models/user.dart';
import 'package:dio/dio.dart';

class AuthService {
  Dio dio;

  AuthService._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: Endpoint.BASE_URL, connectTimeout: 6000, receiveTimeout: 6000);
    dio = Dio(options);
  }

  static final AuthService _instance = AuthService._internal();

  factory AuthService.instance() => _instance;

  Future<SignInRes> signIn(SignInReq req) async {
    Response response = await dio.post(Endpoint.SIGN_IN,
        data: {'email': req.email, 'password': req.password});
    SignInRes res = SignInRes(
        data: User.fromJson(response.data),
        status: response.statusCode,
        message: '${response.headers[KeyHeaders.AUTH_TOKEN][0]}');
    return res;
  }

  Future<ForgotPasswordRes> forgotPassword(ForgotPasswordReq req) async {
    Response response =
        await dio.post(Endpoint.FORGOT_PASSWORD, data: {'email': req.email});
    ForgotPasswordRes res = ForgotPasswordRes(status: response.statusCode);
    return res;
  }
}
