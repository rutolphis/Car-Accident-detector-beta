import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetooth.dart';
import 'package:app/main.dart';

class signIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  var response = "";

  void handleLogin() async {
    var loginResponse =
        await Provider.of<BluetoothConnection>(context, listen: false)
            .user
            .login();

    if (loginResponse == "Login succesful.") {
      setState(() {
        response = "";
      });
      navigatorKey.currentState?.pushNamed(route.connectPage);
    } else {
      setState(() {
        response = loginResponse;
      });
    }
  }

  @override
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
        Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
                maxLength: 30,
                onChanged: (text) {
                  Provider.of<BluetoothConnection>(context, listen: false)
                      .user
                      .setLoginEmail(text);
                },
                decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color(0xFF0D67B5),
                    )))),
        Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: TextFormField(
                obscureText: true,
                maxLength: 30,
                onChanged: (text) {
                  Provider.of<BluetoothConnection>(context, listen: false)
                      .user
                      .setLoginPass(text);
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFF0D67B5),
                    )))),
        ElevatedButton(onPressed: () => handleLogin(), child: Text('Sign In')),
        Text(response, style: const TextStyle(color: Colors.red))
      ])
    ]));
  }
}
