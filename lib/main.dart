import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetooth.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {

  runApp(
      ChangeNotifierProvider<BluetoothConnection>(
          lazy: false,
          create: (_) => BluetoothConnection(),
          child:
            MaterialApp(
              onGenerateRoute: route.controller,
              initialRoute: route.welcomePage,
              navigatorKey: navigatorKey,
        ))
  );
}

