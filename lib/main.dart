import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';
import 'package:app/utilities/bluetooth.dart';

void main() {
  runApp(
      ChangeNotifierProvider<BluetoothConnection>(
          lazy: false,
          create: (_) => BluetoothConnection(),
          child:
            MaterialApp(
          onGenerateRoute: route.controller,
          initialRoute: route.welcomePage,
        ))
  );
}

