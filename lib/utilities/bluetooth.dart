import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:app/utilities/gps.dart';
import 'package:app/utilities/car.dart';
import 'package:app/utilities/user.dart';
import 'package:app/route/route.dart' as route;
import 'package:app/main.dart';


class BluetoothConnection extends ChangeNotifier{
  var device;
  late Gps location;
  late Car car;
  late User user;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  BluetoothConnection(){
    this.location = new Gps();
    this.car = new Car();
    this.user = new User();
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
            if(r.device.name == 'e-call') {
              this.device = r.device;
              flutterBlue.stopScan();
              connectionStatus = await checkConnection(device);
              if(connectionStatus == false) {
                connectionStatus = await connectDevice(this.device);
                if(connectionStatus = false) {
                  return Future.value(false);
                }
              }
              receiveData();
              accidentCheck();
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

  void receiveData() async {
    var targetCharacteristic;
    if(this.device != null) {
      List<BluetoothService> services = await this.device.discoverServices();

      services.forEach((service) async {
        print("Service nazov:${service.uuid}");
        if (service.uuid.toString() == "00000001-710e-4a5b-8d75-3e5b444bc3cf") {
        print("nasiel sa sevice-");
        var characteristics = await service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          //if (c.uuid.toString() == "00000003-710e-4a5b-8d75-3e5b444bc3cf" ||
            // c.uuid.toString() == "00000005-710e-4a5b-8d75-3e5b444bc3cf") {
            await c.setNotifyValue(true);
            c.value.listen((v) {
              this.car.setSpeed(utf8.decode(v));
              notifyListeners();
              print('data: ${utf8.decode(v)}');
            });
            //List<int> data = await c.read();
            //decode = utf8.decode(data);
            //print("Vypis$data");
            //print("Dekodovany vypis:$decode");
          }
        };
       // }
      });
    }
    else{
      print("Ziadne zariadene! (Services)");
    }
  }

  void accidentCheck()  {
    print("nehoda kontrola zacala");
    check() async {
      var connectionStatus = await checkConnection(this.device);
      if(connectionStatus == true) {
        if (this.car.getSpeed() == 11) {
          print('Nehoda sa stala!');
          sendData();
        } else {
          print('Neni nehoda!');
          new Timer(Duration(milliseconds: 2000), check);
        }
      }
      else {
        navigatorKey.currentState?.pushNamed(route.connectPage);
      }
    }
    check();
    return;

  }

  void sendData() async {
    Response response;
    var location = await this.location.determinePosition();
    print(location.longitude);
    final uri = Uri.parse('https://bakalarka-app.herokuapp.com/api/bakalarka/nehoda');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = { "latitude":location.latitude,"longitude":location.longitude,"vin":"WVWZZZ1KZ6B049523","fuel_type":1,"fuel_amount":25,"pedal_position":336,"speed":125,"acceleration":15.88,"rotation":11.2569,"occupied_seats":4, "status":0};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).then((response) {
        print(response.statusCode);
        return Future.value(response);
      });
    }
    catch(error) {
      print("Chyba$error");
    }

  }

  BluetoothDevice? getDevice(){
    return this.device;
  }

  Future<bool> disconnectDevice() async {
    try {
      await this.device.disconnect();
    }
    catch (error) {
      print(error);
      return Future.value(false);
    }

    return Future.value(true);
  }



}