// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_care/features/home/presentation/pages/layout_view.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'compnents.dart';



class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static _requestPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void initialize(BuildContext context) {
    _requestPermissions();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
    void onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: Text(body ?? ''),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                //  Navigator.of(context, rootNavigator: true).pop();
                navigateTo(context, LayoutScreen());
              },
            )
          ],
        ),
      );
    }

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }


  static setNotification(
      {required DateTime time,
        required int id,
        required String body,
        required String title ,
        DateTimeComponents? matchDateTimeComponents}) async {
    Int64List vibrationPattern =  Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
    if (Platform.isAndroid && info.version.sdkInt < 26) {
      await _flutterLocalNotificationsPlugin.schedule(
        id,
        title,
        body,
        time,
         NotificationDetails(
            android: AndroidNotificationDetails(
                'channel id 10', 'Medicine Time',
                channelDescription: 'Medicine Time',
                playSound: true,
                vibrationPattern: vibrationPattern,
                fullScreenIntent: true),
            iOS:const DarwinNotificationDetails(
              presentSound: true,
            )),
        androidAllowWhileIdle: true,
        payload: body,
      );
    } else {
      tz.initializeTimeZones();

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.now(tz.local).add(time.difference(DateTime.now())),
          NotificationDetails(
              android: AndroidNotificationDetails( 'channel id 10', 'Medicine Time',
                  channelDescription: 'Medicine Time',
                  playSound: true,
                  vibrationPattern: vibrationPattern,
                  fullScreenIntent: true),
              iOS:const DarwinNotificationDetails(
                presentSound: true,
              )),
          androidAllowWhileIdle: true,
          payload: body,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static cancelNotification() {
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  static cancelNotificationById(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }
}
