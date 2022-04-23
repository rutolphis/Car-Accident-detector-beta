import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetoothService.dart';
import 'package:app/utilities/bluetooth.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:app/main.dart';


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
    connection.sendData();
    super.initState();
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;


    @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:20, bottom: 50),
                child:
                Speedometer(
                  size: 250,
                  minValue: 0,
                  maxValue: 240,
                  currentValue: Provider.of<BluetoothConnection>(context, listen: true).car.getSpeed(),
                  displayText: 'km/h',
                  backgroundColor: Colors.white,
                  meterColor: Color(0xFF0D67B5),
                  warningColor: Color(0xFF0D67B5),

               )
      ),
                Padding(
                    padding: EdgeInsets.only(left: 20 , right: 20),
                    child:
                    Container(
                        color: Colors.grey, height: 1
                    )
                ),

              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 30),
                child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                          Text('Value 1:'),
                          Text('Value 2:')
                      ]

                    )
      ),
              Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        Text('#N/A'),
                        Text('#N/A')
                      ]

                  )
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        Text('Value 3:'),
                        Text('Value 4:')
                      ]

                  )
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        Text('#N/A'),
                        Text('#N/A')
                      ]

                  )
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        Text('Value 5:'),
                        Text('Value 6')
                      ]

                  )
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        Text('#N/A'),
                        Text('#N/A')
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
        onTap: (index) =>  {
          if(index == 1) {
            navigatorKey.currentState?.pushReplacementNamed( route.settingPage)
          }
        }
      ),);
    }
  }
