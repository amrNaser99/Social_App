// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// class NotificationServices {
//   static final NotificationServices notificationService =
//       NotificationServices._internal();
//
//   factory NotificationServices() {
//     return notificationService;
//   }
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   NotificationServices._internal();
//
//   Future<void> initNotification() async {
//     const AndroidInitializationSettings androidInitialization =
//         AndroidInitializationSettings('logo');
//     const IOSInitializationSettings iosInitialization =
//         IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     const LinuxInitializationSettings linuxInitializationSettings =
//         LinuxInitializationSettings(defaultActionName: 'Twasol');
//     const MacOSInitializationSettings macOSInitializationSettings =
//         MacOSInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitialization,
//       iOS: iosInitialization,
//       linux: linuxInitializationSettings,
//       macOS: macOSInitializationSettings,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//     print('Notification init Successfully');
//   }
//
//   Future<void> showNotification(
//       int id, String title, String body, int seconds) async {
//     flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
//       const NotificationDetails(
//           android: AndroidNotificationDetails('main_channel', 'main Channel',
//               channelDescription: 'main Channel Notification',
//               importance: Importance.max,
//               priority: Priority.max,
//               icon: 'app/src/main/res/drawable/logo.png'),
//           iOS: IOSNotificationDetails(
//             sound: 'default.wav',
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           )),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }
//
//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
//
// }
