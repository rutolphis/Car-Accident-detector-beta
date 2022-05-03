import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:app/utilities/bluetooth.dart';
import 'package:provider/provider.dart';
import 'package:app/main.dart';

class setting extends StatefulWidget {
  @override
  setting();

  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  bool _expanded = false;
  var response = "";
  var numberOne = "";
  var numberTwo = "";
  var numberThree = "";

  void initState() {
    insertNumbers();
    super.initState();
  }

  void insertNumbers() async {
    if (await Provider.of<BluetoothConnection>(context, listen: false)
            .user
            .getNumbers() ==
        true) {
      setState(() {
        numberOne = Provider.of<BluetoothConnection>(context, listen: false)
            .user
            .getNumberOne();
        numberTwo = Provider.of<BluetoothConnection>(context, listen: false)
            .user
            .getNumberTwo();
        numberThree = Provider.of<BluetoothConnection>(context, listen: false)
            .user
            .getNumberThree();
      });
      print(numberOne + numberTwo + numberThree);
    }
  }

  void uploadNumbers() async {
    response = await Provider.of<BluetoothConnection>(context, listen: false)
        .user
        .editNumbers();
    setState(() {
      response;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("device second screen: ${data['device']}");
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text('Settings', style: TextStyle(fontSize: 30))),
            Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.green,
                  child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Add phone numbers',
                              style: TextStyle(color: Color(0xFF0D67B5)),
                            ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            TextFormField(
                                maxLength: 30,
                                key: UniqueKey(),
                                onChanged: (text) {
                                  Provider.of<BluetoothConnection>(context,
                                          listen: false)
                                      .user
                                      .setNumberOne(text);
                                },
                                initialValue: numberOne,
                                decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ))),
                            TextFormField(
                                maxLength: 30,
                                key: UniqueKey(),
                                onChanged: (text) {
                                  Provider.of<BluetoothConnection>(context,
                                          listen: false)
                                      .user
                                      .setNumberTwo(text);
                                },
                                initialValue: numberTwo,
                                decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ))),
                            TextFormField(
                                maxLength: 30,
                                onChanged: (text) {
                                  Provider.of<BluetoothConnection>(context,
                                          listen: false)
                                      .user
                                      .setNumberThree(text);
                                },
                                key: UniqueKey(),
                                initialValue: numberThree,
                                decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ))),
                            ElevatedButton(
                                onPressed: () {
                                  uploadNumbers();
                                },
                                child: Text('Change numbers.'))
                          ],
                        ),
                        isExpanded: _expanded,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.grey,
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded = !_expanded;
                      setState(() {});
                    },
                  ),
                )),
            ElevatedButton(
                onPressed: () async {
                  Provider.of<BluetoothConnection>(context, listen: false)
                      .subscription
                      .cancel();
                  await Provider.of<BluetoothConnection>(context, listen: false)
                      .disconnectDevice();
                  Provider.of<BluetoothConnection>(context, listen: false)
                      .user
                      .logOut();
                },
                child: Text('Log out')),
            Text(response)
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
          if (index == 0)
            {
              navigatorKey.currentState
                  ?.pushReplacementNamed(route.visualizationPage)
            }
        },
      ),
    );
  }
}
