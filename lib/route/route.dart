import 'package:flutter/material.dart';
// importing our pages into our route.dart
import 'package:app/pages/welcome_screen.dart';
import 'package:app/pages/sign_in.dart';
import 'package:app/pages/connect_screen.dart';
import 'package:app/pages/visualization_screen.dart';

// variable for our route names
const String welcomePage = 'welcome';
const String signInPage = 'sign in';
const String connectPage = 'connect';
const String visualizationPage = 'visualization';


// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcomePage:
      return MaterialPageRoute(builder: (context) => welcome());
    case signInPage:
      return MaterialPageRoute(builder: (context) => signIn());
    case connectPage:
      return MaterialPageRoute(builder: (context) => connect());
    case visualizationPage:
      return MaterialPageRoute(builder: (context) => visualization());
    default:
      throw ('this route name does not exist');
  }
}