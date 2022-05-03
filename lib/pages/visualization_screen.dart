import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
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

  FlutterBlue flutterBlue = FlutterBlue.instance;

  Widget engineWidget() {
    if (Provider.of<BluetoothConnection>(context, listen: true)
            .car
            .getEngineStatus() ==
        true) {
      return Text("ON", style: TextStyle(color: Colors.green, fontSize: 18));
    } else {
      return Text("OFF", style: TextStyle(color: Colors.red, fontSize: 18));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 70, bottom: 20, left: 30),
                  child: Speedometer(
                    size: 150,
                    minValue: 0,
                    maxValue: 240,
                    currentValue:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .getSpeed(),
                    displayText: 'km/h',
                    backgroundColor: Colors.white,
                    meterColor: Color(0xFF0D67B5),
                    warningColor: Color(0xFF0D67B5),
                  )),
              Expanded(
                  child: Container(
                      child: Stack(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8,
                        left: MediaQuery.of(context).size.width / 80,
                        bottom: MediaQuery.of(context).size.height / 30),
                    child: Image.asset(
                      'assets/car.png',
                      width: 200,
                      height: 200,
                    )),
                Visibility(
                    visible:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .dot1,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4.1,
                            left: MediaQuery.of(context).size.width / 4.7),
                        child: Image.asset(
                          'assets/greendot.png',
                          width: 20,
                          height: 20,
                        ))),
                Visibility(
                    visible:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .dot2,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4.1,
                            left: MediaQuery.of(context).size.width / 3.4),
                        child: Image.asset(
                          'assets/greendot.png',
                          width: 20,
                          height: 20,
                        ))),
                Visibility(
                    visible:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .dot3,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.4,
                            left: MediaQuery.of(context).size.width / 4.6),
                        child: Image.asset(
                          'assets/greendot.png',
                          width: 20,
                          height: 20,
                        ))),
                Visibility(
                    visible:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .dot4,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.4,
                            left: MediaQuery.of(context).size.width / 3.9),
                        child: Image.asset(
                          'assets/greendot.png',
                          width: 20,
                          height: 20,
                        ))),
                Visibility(
                    visible:
                        Provider.of<BluetoothConnection>(context, listen: true)
                            .car
                            .dot5,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.4,
                            left: MediaQuery.of(context).size.width / 3.4),
                        child: Image.asset(
                          'assets/greendot.png',
                          width: 20,
                          height: 20,
                        )))
              ]))),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(color: Colors.grey, height: 1)),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 30, right: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text('VIN:'), Text('Temperature:')])),
            Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .getVin(),
                          style: TextStyle(
                            color: Color(0xFF0D67B5),
                            fontSize: 16,
                          )),
                      Text(
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .getTemperature(),
                          style: TextStyle(
                            color: Color(0xFF0D67B5),
                            fontSize: 18,
                          ))
                    ])),
            Padding(
                padding: EdgeInsets.only(bottom: 20, right: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text('RPM:'), Text('Pedal position:')])),
            Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .getRmp(),
                          style: TextStyle(
                            color: Color(0xFF0D67B5),
                            fontSize: 18,
                          )),
                      Text(
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .getPedalPosition(),
                          style: TextStyle(
                            color: Color(0xFF0D67B5),
                            fontSize: 18,
                          ))
                    ])),
            Padding(
                padding: EdgeInsets.only(bottom: 20, right: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Engine status:'),
                      Text('G Force:')
                    ])),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      engineWidget(),
                      Text(
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .getGForce()
                              .toStringAsFixed(2),
                          style: TextStyle(
                            color: Color(0xFF0D67B5),
                            fontSize: 18,
                          ))
                    ])),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .accelarationX +
                          " " +
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .accelarationY +
                          " " +
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .accelarationZ),
                      Text(Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .rotationX +
                          " " +
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .rotationY +
                          " " +
                          Provider.of<BluetoothConnection>(context,
                                  listen: true)
                              .car
                              .rotationZ)
                    ]))
          ]),
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
          onTap: (index) => {
                if (index == 1)
                  {
                    navigatorKey.currentState
                        ?.pushReplacementNamed(route.settingPage)
                  }
              }),
    );
  }
}
