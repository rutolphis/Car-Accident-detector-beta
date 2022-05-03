import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:app/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:app/utilities/notificationService.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage('assets/Car Accident detector-logos.jpeg'),
                  height: 250,
                  fit: BoxFit.fill,
                ))),
        Text('Welcome', style: TextStyle(fontSize: 30)),
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: OutlinedButton(
                onPressed: () {
                  navigatorKey.currentState?.pushNamed(route.signInPage);
                },
                child: Text('Sign in'))),
        ElevatedButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamed(route.signUpPage);
            },
            child: Text('Sign up'))
      ]),
    ]));
  }
}
