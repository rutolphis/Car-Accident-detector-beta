import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';
import 'package:app/utilities/bluetooth.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';


class setting extends StatefulWidget {
  @override
  setting();
  _settingState createState() => _settingState();

}

class _settingState extends State<setting> {

  var device;
  var connection;

  void initState() {
    super.initState();
  }


  FlutterBlue flutterBlue = FlutterBlue.instance;


  @override
  Widget build(BuildContext context) {
    //print("device second screen: ${data['device']}");
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(child:
              Text('settings')
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Expanded(
                      child: Text('sracky')),
                  Expanded(child: Text('cau'))
                ]
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
        onTap: (index) =>  Navigator.pushNamed(context, route.visualizationPage),
      ),);
  }
}
