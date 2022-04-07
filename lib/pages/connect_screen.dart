import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app/pages/visualization_screen.dart';
import 'package:app/utilities/bluetooth.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';


class connect extends StatefulWidget {
  @override
  _connectState createState() => _connectState();

}

class _connectState extends State<connect> {
  @override
  void initState() {
    connection = Provider
        .of<BluetoothConnection>(context, listen: false);
    connection.bluetoothConnection();
    connectionCheck();
    super.initState();
  }

  void connectionCheck()  {

    bool connectionStatus = false;

    check() async {
      device = connection
          .getDevice();

        if(device != null) {
          connectionStatus = await connection.checkConnection(device);
        }

        if (connectionStatus && device != null) {
          setState(() {
            color = Color(0xFF00E676);
            status = 'Connected.';
          });
          Future.delayed(Duration(seconds: 2), () {
            Navigator.popAndPushNamed(context, route.visualizationPage);
          });
        } else {
          print('not Connected');
          new Timer(Duration(milliseconds: 2000), check);
        }
      }
      check();
      return;

  }

  var status = 'Not connected';
  Color color = Color(0xffadadad);
  var device;
  var connection;

  Widget build(BuildContext context){
    return Scaffold(
          body: Column(
            children: <Widget>[
            Image(image: AssetImage('assets/Car Accident detector-logos.jpeg')),
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
