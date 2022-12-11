import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schedule_app/config/index_app.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:schedule_app/services/firestore/schedule.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await initializeService();
  runApp(const IndexApp());
  easyLoadingConfig();
}

void easyLoadingConfig() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue[700]
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue[700]
    ..textColor = Colors.blue[700]
    ..maskColor = Colors.black26
    ..userInteractions = true
    ..dismissOnTap = false;
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'schedule123', // id
    'schedule service', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: (service) => false,
    ),
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'schedule123',
      initialNotificationTitle: 'schedule service',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  GetStorage _box = GetStorage();

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  // bring to foreground
  // if (_box.read('user') != null) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final Iterable<ScheduleModel> now = await ScheduleStore.readBackground();
    print(now.length.toString());
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        if (now.isNotEmpty) {
          for (var element in now.toList()) {
            // print('MASUK COY BURUAN');
            // flutterLocalNotificationsPlugin.show(
            //   888,
            //   'Anda memasuki jadwal ${element.name}',
            //   'Pada tanggal ${element.date}, pukul ${element.time}',
            //   const NotificationDetails(
            //     android: AndroidNotificationDetails(
            //       'schedule123',
            //       'schedule service',
            //       ongoing: true,
            //     ),
            //   ),
            // );
            service.setForegroundNotificationInfo(
              title: "Anda memasuki jadwal ${element.name}",
              content: "Pada tanggal ${element.date}, pukul ${element.time}",
            );
          }
        }
      } else {
        if (now.isNotEmpty) {
          for (var element in now.toList()) {
            print('masuk yuk');
            service.setForegroundNotificationInfo(
              title: "Anda memasuki jadwal ${element.name}",
              content: "Pada tanggal ${element.date}, pukul ${element.time}",
            );
          }
        }
      }
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin

    //if (Platform.isAndroid) {}

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
}
// }
