import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

// import 'package:overlay_support/overlay_support.dart';

import '../../constants/appColor.dart';
import '../../core/locales/i18nKey.dart';
import '../../core/routes/routeName.dart';
import '../../models/notification/push_notification.dart';
import '../../utils/screenUtil.dart';
import '../../widgets/appAppBar.dart';
import '../../widgets/appBotNav.dart';
import '../addMeeting/addMeetingView.dart';
import '../base/baseView.dart';
import '../myMeeting/myMeetingView.dart';
import '../notification/notificationView.dart';
import '../roomMeeting/roomMeetingView.dart';
import '../setting/settingView.dart';
import 'homeModel.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseMessaging _messaging;
  PushNotification _notificationInfo;
  // int _totalNotifications;
  Future<void> _showNotification({String title, String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title ?? '',
      body ?? '',
      platformChannelSpecifics,
      payload: selectedNotificationPayload,
    );
  }

  void _requestPermissionsLocal() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'].toString(),
          dataBody: message.data['body'].toString(),
        );

        setState(() {
          _notificationInfo = notification;
          // _totalNotifications++;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          /* showSimpleNotification(
            Text(_notificationInfo.title),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo.body),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          ); */
          _showNotification(
            title: _notificationInfo.title,
            body: _notificationInfo.body,
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
    //Get FCM token
    _messaging?.getToken()?.then(
      (fcmToken) {
        log('fcmToken: $fcmToken');
      },
    )?.catchError((dynamic err) {
      log('Has some errors on get fcmToken: $err');
    });
  }

  // For handling notification when the app is in terminated state
  void checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'].toString(),
        dataBody: initialMessage.data['body'].toString(),
      );

      setState(() {
        _notificationInfo = notification;
        // _totalNotifications++;
      });
    }
  }

  @override
  void initState() {
    // _totalNotifications = 0;
    _requestPermissionsLocal();
    registerNotification();
    checkForInitialMessage();
    _initLocalPushNotification();
    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'].toString(),
        dataBody: message.data['body'].toString(),
      );

      setState(() {
        _notificationInfo = notification;
        // _totalNotifications++;
      });
    });

    super.initState();
  }

  _initLocalPushNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification:
                (int id, String title, String body, String payload) async {
              didReceiveLocalNotificationSubject.add(ReceivedNotification(
                  id: id, title: title, body: body, payload: payload));
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });
  }

  Widget _buildView(int index) {
    switch (index) {
      case 0:
        return RoomMeetingView();
      case 1:
        return MyMeetingView();
      case 2:
        return NotificationView();
      case 3:
        return SettingView();
      case 4:
        return AddMeetingView();
      default:
        return RoomMeetingView();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BaseView<HomeModel>(
        model: HomeModel(),
        builder: (context, model, _) {
          return Scaffold(
            appBar: model.currentIndex != 3
                ? AppAppBar(
                    centerTitle: true,
                    title: '${ScreenUtil.t(model.currentTitle)}',
                  )
                : null,
            // drawer: AppDrawer(
            //   callback: (route) {
            //     model.navigate(route);
            //     Navigator.of(context).pop();
            //   },
            // ),
            bottomNavigationBar: AppBotNav(
              centerItemText: '${ScreenUtil.t(I18nKey.orderRoom)}',
              color: Colors.grey,
              backgroundColor: Colors.white,
              selectedColor: AppColor.primary,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (index) => model.navigate(index),
              items: [
                AppBotNavItem(
                    iconData: Icons.dashboard,
                    title: '${ScreenUtil.t(I18nKey.meetingRoom)}'),
                AppBotNavItem(
                    iconData: Icons.person,
                    title: '${ScreenUtil.t(I18nKey.my)}'),
                AppBotNavItem(
                    iconData: Icons.notifications,
                    title: '${ScreenUtil.t(I18nKey.notification)}'),
                AppBotNavItem(
                    iconData: Icons.menu,
                    title: '${ScreenUtil.t(I18nKey.more)}'),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.addMeeting);
              },
              child: Icon(Icons.add),
              elevation: 2.0,
            ),
            body: _buildView(model.currentIndex),
          );
        });
  }
}
