import 'package:demo_b/core/locales/i18nKey.dart';
import 'package:demo_b/core/routes/routeName.dart';
import 'package:demo_b/modules/base/baseModel.dart';

class HomeModel extends BaseModel {
  int currentIndex = 0;
  String currentRoute = RouteName.roomMeeting;
  String currentTitle = I18nKey.meetingRoom;

  void navigate(int value) {
    if (value == currentIndex) return;
    currentIndex = value;
    _updateCurrentRoute();
    _updateCurrentTitle();
    notifyListeners();
  }

  void _updateCurrentRoute() {
    switch (currentIndex) {
      case 0:
        currentRoute = RouteName.roomMeeting;
        break;
      case 1:
        currentRoute = RouteName.myMeeting;
        break;
      case 2:
        currentRoute = RouteName.notification;
        break;
      case 3:
        currentRoute = RouteName.setting;
        break;
      case 4:
        currentRoute = RouteName.addMeeting;
        break;
      default:
        currentRoute = RouteName.roomMeeting;
        break;
    }
  }

  void _updateCurrentTitle() {
    switch (currentIndex) {
      case 0:
        currentTitle = I18nKey.meetingRoom;
        break;
      case 1:
        currentTitle = I18nKey.my;
        break;
      case 2:
        currentTitle = I18nKey.notification;
        break;
      case 3:
        currentTitle = I18nKey.more;
        break;
      case 4:
        currentTitle = I18nKey.orderRoom;
        break;
      default:
        currentTitle = I18nKey.meetingRoom;
        break;
    }
  }
}
