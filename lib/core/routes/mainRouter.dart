import 'package:demo_b/core/routes/dialogPageRoute.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/models/control/room.dart';
import 'package:demo_b/modules/addMeeting/addMeetingView.dart';
import 'package:demo_b/modules/addMeeting/selectParticipant/selectParticipantView.dart';
import 'package:demo_b/modules/addMeeting/selectRepeat/selectRepeatView.dart';
import 'package:demo_b/modules/addMeeting/selectRoom/selectRoomView.dart';
import 'package:demo_b/modules/adminControl/deviceListControl/deviceListControlView.dart';
import 'package:demo_b/modules/adminControl/roomListControl/roomListControlView.dart';
import 'package:demo_b/modules/forgotPassword/forgotPasswordView.dart';
import 'package:demo_b/modules/home/homeView.dart';
import 'package:demo_b/modules/meetingCalendar/meetingCalendarView.dart';
import 'package:demo_b/modules/meetingDetails/meetingDetailsView.dart';
import 'package:demo_b/modules/signIn/signInView.dart';
import 'package:demo_b/modules/splash/splashView.dart';
import 'package:flutter/material.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
        return MaterialPageRoute<dynamic>(builder: (_) => SplashView());
      case RouteName.signIn:
        return MaterialPageRoute<dynamic>(builder: (_) => SignInView());
      case RouteName.forgotPassword:
        return MaterialPageRoute<dynamic>(builder: (_) => ForgotPasswordView());
      case RouteName.home:
        return MaterialPageRoute<dynamic>(builder: (_) => HomeView());
      case RouteName.addMeeting:
        return DialogPageRoute<dynamic>(builder: (_) => AddMeetingView());
      case RouteName.selectRoom:
        return MaterialPageRoute<dynamic>(builder: (_) => SelectRoomView());
      case RouteName.selectParticipant:
        return MaterialPageRoute<dynamic>(
            builder: (_) => SelectParticipantView());
      case RouteName.selectRepeat:
        return MaterialPageRoute<dynamic>(builder: (_) => SelectRepeatView());
      case RouteName.meetingDetails:
        return MaterialPageRoute<dynamic>(builder: (_) => MeetingDetailsView());
      case RouteName.meetingCalendar:
        return MaterialPageRoute<dynamic>(
            builder: (_) => MeetingCalendarView());
      case RouteName.roomListControl:
        return MaterialPageRoute<dynamic>(
            builder: (_) => RoomListControlView());
      case RouteName.deviceListControl:
        return MaterialPageRoute<dynamic>(
            builder: (_) => DeviceListControlView(settings.arguments as Room));
      default:
        return MaterialPageRoute<dynamic>(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          );
        });
    }
  }
}
