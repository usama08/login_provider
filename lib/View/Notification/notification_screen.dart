import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPersmission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permkissions");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted provisional permkissions");
    } else {
      print("user denied permkissions");
    }
  }

///// --------   Local Notifications with icon ------------ /////

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    // ignore: non_constant_identifier_names
    var InitializationSetting = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await _flutterLocalNotificationsPlugin.initialize(InitializationSetting,
        onDidReceiveNotificationResponse: (payloaad) {
      handleMessagge(context, message);
    });
  }

/////  -------------   firebase function initialization ------------  /////

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);
      }
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

//////  -----------   show Notification function ------------  //////

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        "High Importance Notification",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Your Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  /////// --------------   Get Device Token  ------------   ///////

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  /////// ---------------   Refresh New Token generate ---------///////
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessagge(context, initialMessage);
    }
    // when app is innackground
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessagge(context, event);
    });
  }

//////// ---------------  Handle Messge  ------------------- /////////
  void handleMessagge(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      Navigator.pushNamed(context, '/clintscreen');
    }
  }
}
