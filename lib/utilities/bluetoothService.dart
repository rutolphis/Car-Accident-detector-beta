
import 'package:app/utilities/bluetooth.dart';
import 'package:flutter/foundation.dart';

class BluetoothServices with ChangeNotifier {
  late BluetoothConnection connection;

  BluetoothServices(){
    connection = new BluetoothConnection();
  }

}