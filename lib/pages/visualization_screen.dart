import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';
import 'package:app/utilities/bluetooth.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';


class visualization extends StatefulWidget {
  @override
  var device;
  _visualizationState createState() => _visualizationState();

}

class _visualizationState extends State<visualization> {

  var device;
  var connection;

  void initState() {
    connection = Provider
        .of<BluetoothConnection>(context, listen: false);
    super.initState();
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;


    @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Speedometer(
                  size: 250,
                  minValue: 0,
                  maxValue: 240,
                  currentValue: Provider.of<BluetoothConnection>(context, listen: true).car.getSpeed(),
                  displayText: 'km/h',
                  backgroundColor: Colors.white,
                  meterColor: Color(0xFF0D67B5),
                  warningColor: Color(0xFF0D67B5),

               ),
              Expanded(
                child:
                Divider(
                    color: Colors.black
                )
              ),
              Expanded(
                child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Expanded(
                    child: Text('No. of passengers:')),
                  Expanded(
                      child: Text('Car model:'))
                ]
              )
              )
            ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Overview",
            backgroundColor: Color(0xFF0D67B5),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: Color(0xFF0D67B5),
          )
        ],
        backgroundColor: Color(0xFF0D67B5),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: (index) =>  Navigator.pushNamed(context, route.settingPage)
      ),);
    }
  }
