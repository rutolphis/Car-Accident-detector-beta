import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createAccidentNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: 'basic_channel',
      title:
      'Accident happend!',
      body: 'Go to app and validate accident.',
    ),
  );
}