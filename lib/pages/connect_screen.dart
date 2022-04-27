import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:app/utilities/bluetooth.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:app/main.dart';


class connect extends StatefulWidget {
  @override
  _connectState createState() => _connectState();

}

class _connectState extends State<connect> {
  @override
  void initState() {
    connectionCheck();
    super.initState();
  }


  void connectionCheck() async {

    if (await Provider
        .of<BluetoothConnection>(context, listen: false).bluetoothConnection() == true) {
      setState(() {
        color = Color(0xFF00E676);
        status = 'Connected.';
      });
      Future.delayed(Duration(seconds: 2), () async {
        await navigatorKey.currentState?.popAndPushNamed(route.visualizationPage);
      });
    }
    else {
      _showMaterialDialog();
    }

  }

  void _showMaterialDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Device not found!'),
            content: Text('Hey! Device wasnt found, so you can try to search agan or log out!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    connectionCheck();
                    _dismissDialog();
                  },
                  child: Text('Continue searching!')),
              TextButton(
                onPressed: () async {
                  _dismissDialog();
                  Provider
                      .of<BluetoothConnection>(context, listen: false).subscription.cancel();
                  Provider
                      .of<BluetoothConnection>(context, listen: false).device = null;
                  await Provider
                      .of<BluetoothConnection>(context, listen: false).disconnectDevice();
                  Provider
                      .of<BluetoothConnection>(context, listen: false).user.logOut();
                },
                child: Text('Log out!'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    navigatorKey.currentState?.pop();
  }

    var status = 'Not connected';
    Color color = Color(0xffadadad);

    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child:
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child:
                      Image(
                        image: AssetImage('assets/Car Accident detector-logos.jpeg'),
                        height: 250,
                        fit: BoxFit.fill,
                      )
                  )
              ),
              Text(
                  'How to connect',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis
              ),
              Text(
                '1. Plug and start device to the car.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '2. Turn on Bluetooth on your mobile device and wait for connection.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: 240.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: color,
                ),
                child: Center(
                  child: Text(
                    'Connection status:\n$status',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]
        ),


      );
    }
  }
