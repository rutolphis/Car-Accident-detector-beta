import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:app/utilities/car.dart';
import 'package:http/http.dart';
import 'package:app/utilities/gps.dart';
import 'package:app/utilities/user.dart';
import 'package:app/route/route.dart' as route;
import 'package:app/main.dart';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';


class BluetoothConnection extends ChangeNotifier{
  var device;
  late Gps location;
  late User user;
  late Car car;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool accidentStatus = false;
  bool shock = false;
  late StreamSubscription<FGBGType> subscription;
  late FGBGType appStatus;

  BluetoothConnection(){
    this.location = new Gps();
    this.car = new Car();
    this.user = new User();
  }

  Future<bool> bluetoothConnection () async{
    int count = 0;
    bool connectionStatus = false;

    if(await flutterBlue.isAvailable == true) {
      await Future.doWhile(() async {
        connectionStatus = await searchDevice();
        print("status pripojenia:$connectionStatus");
        if(connectionStatus == false && count <= 3) {
          print(count);
          count++;
          return true;
        }
        else if(connectionStatus == true) {
          print("pripojenie uspesne");
          shockDetector();
          subscription = FGBGEvents.stream.listen((event) {
            appStatus = event; // FGBGType.foreground or FGBGType.background
          });
          Future.doWhile(() async {
            if(await checkConnection(this.device) == true && this.user.token != null) {
              return true;
            }
            else if(this.user.token == null){
              print("odhlaseny");
              return false;
            }
            else if(this.shock == true) {
              if (await Vibration.hasVibrator()) {
                Vibration.vibrate();
              }
              print("odpojeny ale naraz");
              showMaterialDialogSpecial();
              return false;
            }
            else{
              print("odpojeny");
              this.device = null;
              await navigatorKey.currentState?.pushReplacementNamed(route.connectPage);
              return false;
            }
          });
          return false;
        }
        else{
          return false;
        }

      });

      return Future.value(connectionStatus);

    }
    else {
      print("Device doenst have bluetooth");
      return Future.value(false);
    }

  }

  Future<bool> searchDevice() async {
    bool connectionStatus = false;
    if (await flutterBlue.isOn == false) {
      print("Bluetooth is off.");
      await BluetoothEnable.enableBluetooth;
    }
    if (await flutterBlue.isOn == true) {
      print("Bluetooth is on.");
      flutterBlue.startScan(timeout: Duration(seconds: 5));
      flutterBlue.scanResults.listen((results) async {
        for (ScanResult r in results) {
          print(r.device);
          if (r.device.name == 'e-call') {
            this.device = r.device;
            await flutterBlue.stopScan();
            connectionStatus = await checkConnection(device);
            if (connectionStatus == false) {
              connectionStatus = await connectDevice(this.device);
              print("status po pripojeni:$connectionStatus");
              if (connectionStatus == false) {
                return Future.value(false);
              }
            }
            receiveData();
            //accidentCheck();
            return Future.value(true);
          }
        }
      });

      await Future.delayed(Duration(seconds: 6));
      await flutterBlue.stopScan();
      print("status pri posielani:$connectionStatus");
      return Future.value(connectionStatus);

    }
    else {
      return Future.value(false);
    }

  }

  Future<bool> connectDevice(device) async {
    print("device: $device");
    if(device != null) {
      await device.connect(autoConnect: false);

      if(await checkConnection(device) == true){
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

    if(device != null) {
      if (connectedDevices.contains(device)) {
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

  void shockDetector(){
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      double g = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if(g > 20){
        print(g);
        shock = true;
        Future.delayed(Duration(seconds: 3), () {
          shock = false;
        });
      }
    });
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
          if (c.uuid.toString() == "00000002-710e-4a5b-8d75-3e5b444bc3cf" ) {
            await c.setNotifyValue(true);
            c.value.listen((v) async {
              parseData(utf8.decode(v));
              notifyListeners();
              if (this.car.getGForce() > 2) {
                print('Nehoda sa stala!');
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate();
                  }
                showMaterialDialogNormal();
                //sendData();
              } else {
                print('Neni nehoda!');
              }
              print('data: ${utf8.decode(v)}');
            });
            //List<int> data = await c.read();
            //decode = utf8.decode(data);
            //print("Vypis$data");
            //print("Dekodovany vypis:$decode");
          }
        };
        }
      });
    }
    else{
      print("Ziadne zariadene! (Services)");
    }
  }

  String? currentScreen() {
    String? currentPath;
    navigatorKey.currentState?.popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });

    return currentPath;
  }

  void sendData() async {
    Response response;
    var location = await this.location.determinePosition();
    print(location.longitude);
    final uri = Uri.parse('https://bakalarka-app.herokuapp.com/api/bakalarka/nehoda');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = { "latitude":location.latitude,"longitude":location.longitude,"vin":"WVWZZZ1KZ6B049523","fuel_type":1,"fuel_amount":25,"pedal_position":int.tryParse(car.getPedalPosition()) ?? 0,"speed":car.getSpeed(),"acceleration":15.88,"rotation":11.2569,"occupied_seats":car.getSeats(), "status": 1};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).then((response) {
        print("Odpoved:${response.body}");
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
      if(device != null) {
        await this.device.disconnect();
        this.device = null;
      }
    }
    catch (error) {
      print(error);
      return Future.value(false);
    }

    return Future.value(true);
  }

  void showMaterialDialogNormal() {
    Future.delayed(Duration(seconds: 15), () {
      if(this.accidentStatus == true){
        this.accidentStatus = false;
      }
      else{
        sendData();
        dismissDialog();
      }
    });
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('The accident was recorded!',style: TextStyle(color: Colors.red)),
            content: Text('Hey! Accident was recorder by our system, you have 15 seconds to stop system from sending data to rescue services !'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    this.accidentStatus = true;
                    dismissDialog();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                    ),
                  child: Text('No Accident!')),
              TextButton(
                onPressed: () async {
                  this.accidentStatus = true;
                  sendData();
                  dismissDialog();
                },
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Send rescue services!'),
              )
            ],
          );
        });
  }

  void showMaterialDialogSpecial() {
    Future.delayed(Duration(seconds: 30), () {
      if(this.accidentStatus == true){
        this.accidentStatus = false;
      }
      else{
        sendData();
        dismissDialog();
      }
    });
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('The accident was recorded!',style: TextStyle(color: Colors.red)),
            content: Text('Hey! Accident was recorder by our system, you have 30 seconds to stop system from sending data to rescue services!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    this.device = null;
                    this.accidentStatus = true;
                    dismissDialog();
                    await navigatorKey.currentState?.pushReplacementNamed(route.connectPage);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('No Accident!')),
              TextButton(
                onPressed: () async {
                  this.device = null;
                  this.accidentStatus = true;
                  sendData();
                  dismissDialog();
                  await navigatorKey.currentState?.pushReplacementNamed(route.connectPage);
                },
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Send rescue services!'),
              )
            ],
          );
        });
  }

  void dismissDialog() {
    navigatorKey.currentState?.pop();
  }

  void parseData(data) {
    var parsedList;
    if(data == null) {
      return;
    }else {
      parsedList = data.split(",");
      print(parsedList);
      car.setSpeed(parsedList[0]);
      car.setRmp(parsedList[1]);
      car.setPedalPosition(parsedList[2]);
      car.setTemperature(parsedList[3]);
      car.calculateG(double.tryParse(parsedList[4]) ?? 0, double.tryParse(parsedList[5]) ?? 0, double.tryParse(parsedList[6]) ?? 0);
      car.setDots(parsedList[10]);
      car.setEngineStatus();

    }
  }

}