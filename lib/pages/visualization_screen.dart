import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';

class visualization extends StatefulWidget {
  @override
  var device;
  visualization({this.device});
  _visualizationState createState() => _visualizationState(device);

}

class _visualizationState extends State<visualization> {

  var device;
  _visualizationState(this.device);

  void searchServices() async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      print(service);
    });
  }

  @override
  Widget build(BuildContext context){
    //print("device second screen: ${data['device']}");
    print("device scren two: $device");
    searchServices();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Visualization screen')
        ]
    ),);
}
}