import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart';



class BluetoothConnection extends ChangeNotifier{
  var device;
  var speed;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  BluetoothConnection(){
  }

  Future<bool> bluetoothConnection (){
    bool connectionStatus;

    FlutterBlue.instance.state.listen((state) async {
      if (state == BluetoothState.off) {
        print("Bluetooth is off.");
      } else if (state == BluetoothState.on) {
        print("Bluetooth is on.");
        flutterBlue.startScan(timeout: Duration(seconds: 50));
        flutterBlue.scanResults.listen((results) async {
          for (ScanResult r in results) {
            print(r.device);
            if(r.device.name == 'car') {
              this.device = r.device;
              flutterBlue.stopScan();
              connectionStatus = await checkConnection(device);
              if(connectionStatus == false) {
                connectionStatus = await connectDevice(this.device);
                if(connectionStatus = false) {
                  return Future.value(false);
                }
              }
            }
          }
        });
      }
    });
    return Future.value(false);
  }

  Future<bool> connectDevice(device) async {
    print("device: $device");
    if(device != null) {
      await device.connect(autoConnect: false);

      if(checkConnection(device) == true){
        return Future.value(true);
      }
      else {
        return Future.value(false);
      }
    }
    else{
      return Future.value(false);
    }
  }

  Future<bool> checkConnection(device) async {
    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;

    print("Pripojene zariadenia: $connectedDevices");
    if(device != null) {
      if (connectedDevices.contains(device)) {
        print('pripojene');
        return Future.value(true);
      }
      else {
        return Future.value(false);
      }
    }
    else {
      return Future.value(false);
    }
  }

  void searchServices() async {
    var targetCharacteristic;
    if(this.device != null) {
      List<BluetoothService> services = await this.device.discoverServices();

      services.forEach((service) async {
        print("Service nazov:${service.uuid}");
        //if (service.uuid.toString() == "00000002-710e-4a5b-8d75-3e5b444bc3cf") {
        print("nasiel sa sevice-");
        var characteristics = await service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          //if (c.uuid.toString() == "00000002-710e-4a5b-8d75-3e5b444bc3cf" ||
            //  c.uuid.toString() == "00000003-710e-4a5b-8d75-3e5b444bc3cf") {
            await c.setNotifyValue(true);
            c.value.listen((v) {
              this.speed = utf8.decode(v);
              notifyListeners();
              print('data: ${utf8.decode(v)}');
            });
            //List<int> data = await c.read();
            //decode = utf8.decode(data);
            //print("Vypis$data");
            //print("Dekodovany vypis:$decode");
          //}
        };
        //}
      });
    }
    else{
      print("Ziadne zariadene! (Services)");
    }
  }

  String getSpeed(){
    if(this.speed == null){
      return "0";
    }
    else{
      return this.speed;
    }
  }

  BluetoothDevice? getDevice(){
    return device;
  }



}