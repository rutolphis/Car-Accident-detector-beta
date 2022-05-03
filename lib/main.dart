import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetooth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
      ),
    ],
  );

  runApp(ChangeNotifierProvider<BluetoothConnection>(
      lazy: false,
      create: (_) => BluetoothConnection(),
      child: MaterialApp(
        onGenerateRoute: route.controller,
        initialRoute: route.welcomePage,
        navigatorKey: navigatorKey,
      )));
}
