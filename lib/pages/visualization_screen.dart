import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';
import 'package:app/utilities/bluetooth.dart';


class visualization extends StatefulWidget {
  @override
  var device;
  visualization({this.device});
  _visualizationState createState() => _visualizationState(device);

}

class _visualizationState extends State<visualization> {

  var device;
  var connection;

  void initState() {
    connection = Provider
        .of<BluetoothConnection>(context, listen: false);
    connection.searchServices();
    super.initState();
  }

  _visualizationState(this.device);

  FlutterBlue flutterBlue = FlutterBlue.instance;


    @override
    Widget build(BuildContext context) {
      //print("device second screen: ${data['device']}");
      return Scaffold(
        body: Column(
            children: <Widget>[
              Center(
                  child: Text(Provider.of<BluetoothConnection>(context, listen: true).getSpeed())
              )
            ]
        ),);
    }
  }
