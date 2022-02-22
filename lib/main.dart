import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;

void main() {
  runApp(MaterialApp(
    onGenerateRoute: route.controller,
    initialRoute: route.welcomePage,
  ));
}

