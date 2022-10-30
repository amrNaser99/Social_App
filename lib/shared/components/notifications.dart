// import 'package:awesome_notifications/awesome_notifications.dart';
//
// int createUniqueId() {
//   return DateTime.now().microsecondsSinceEpoch.remainder(1000000);
// }
//
// Future<void> createNotification({
//   required String notificationTitle,
//   required String notificationBody,
//   String? notificationPicture,
// }) async {
//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//     id: createUniqueId(),
//     channelKey: 'basic_channel',
//     title: notificationTitle,
//     body: notificationBody,
//     bigPicture: notificationPicture,
//     notificationLayout: notificationPicture != null
//         ? NotificationLayout.BigPicture
//         : NotificationLayout.Default,
//   ));
// }
