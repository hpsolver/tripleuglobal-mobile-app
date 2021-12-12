import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tripleuglobal/constants/constant_color.dart';

import '../routes.dart';

class FirebaseNotification {
  late FirebaseMessaging _firebaseMessaging;
  BuildContext? context;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  var userProfile;
  var userName;
  var userId;

  FirebaseNotification() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  Future<String?> getToken() async {
    var value = await _firebaseMessaging.getToken();
    print("firebase token is $value");
    return value;
  }

  void configureFireBase(BuildContext context) {
    this.context = context;
    flutterNotification(context);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      print("the notification is $notification");
      var title = "";
      var body = "";
      bool isIOS = Platform.isIOS;
      if (isIOS) {
        body = notification.body!;
        title = notification.body!;
      } else {
        var data = notification;
        body = data.body!;
        title = data.title!;
      }
      var android = new AndroidNotificationDetails(
          '1', 'Triple', 'CHANNEL DESCRIPTION',
          color: kPrimaryColor,priority: Priority.high, importance: Importance.max);
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);
      await _flutterLocalNotificationsPlugin.show(0, title, body, platform);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      intentToNextScreen(message);
    });
  }

  void flutterNotification(BuildContext context) {
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  intentToNextScreen(notification) {
    bool isIOS = Platform.isIOS;
    String notificationType = "";
    var roomId = "";

    if (isIOS) {
      notificationType = notification["type"];
      var notiData = notification["notiData"];
      var decodedData = jsonDecode(notiData);
      roomId = decodedData["roomId"];
    } else {
      notificationType = notification["data"]["type"];
      var notiData = notification["data"]["notiData"];
      var decodedData = jsonDecode(notiData);
      roomId = decodedData["roomId"];
    }
    if (notificationType == "0" ||
        notificationType == "1" ||
        notificationType == "2") {
      var data = {
        "userorRoomId": roomId,
        "name": "deepak",
        "from": "notificationPage",
        "roomType": notificationType
      };
      Navigator.of(context!).pushNamed(MyRoutes.home, arguments: data);
    }

    Navigator.of(context!).pushNamed(MyRoutes.home);
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      intentToNextScreen(json.decode(payload));
    }
  }
}
