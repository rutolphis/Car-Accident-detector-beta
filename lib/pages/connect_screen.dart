import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:flutter_blue/flutter_blue.dart';



class connect extends StatefulWidget {
  @override
  _connectState createState() => _connectState();

}

class _connectState extends State<connect> {
  @override
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var status = 'Not connected';
  var devicesList = [];
  var device;

  bool bluetoothConnection (){
    FlutterBlue.instance.state.listen((state) async {
      if (state == BluetoothState.off) {
        print("Bluetooth is off.");
      } else if (state == BluetoothState.on) {
        print("Bluetooth is on.");
        flutterBlue.startScan(timeout: Duration(seconds: 50));
        flutterBlue.scanResults.listen((results) {
          for (ScanResult r in results) {
            print(r.device);
            if(r.device.name == 'BLE Device') {
              device = r.device;
              flutterBlue.stopScan();
              connectDevice(device);
            }
          }
        });

        //Future.delayed(const Duration(seconds: 6), () => flutterBlue.stopScan());
        //Future.delayed(const Duration(seconds: 6), () => findDevice());
        //Future.delayed(const Duration(seconds: 7), () => connectDevice(device));
      }
    });
    return true;
  }

  void findDevice() {
      print('list: $devicesList');
      var myListFiltered = devicesList.where((e)
      =>
      e.name == 'BLE Device'
      ).toList();
      myListFiltered = myListFiltered.toSet().toList();
      if (myListFiltered.length > 0) {
        print('Hladane zariadenie:${myListFiltered[0]}');
        device = myListFiltered[0];
      } else {
        return ;
      }
  }

  void connectDevice(device) async {
    print("device: $device");
    if(device != null) {
      await device.connect(autoConnect: false);

      List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;

      print("Pripojene zariadenia: $connectedDevices");
      if(connectedDevices.contains(device)) {
          print('pripojene');
      }
      else {
          print('neni');
      }
      }
    else{
      print("Nenaslo sa zariadenie");
    }
    }


  Widget build(BuildContext context){
    bluetoothConnection();

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
        color: const Color(0xffadadad),
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
