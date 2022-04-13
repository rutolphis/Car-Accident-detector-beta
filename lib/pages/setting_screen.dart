import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;

class setting extends StatefulWidget {
  @override
  setting();
  _settingState createState() => _settingState();

}

class _settingState extends State<setting> {
  bool _expanded = false;

  void initState() {
    super.initState();
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
              padding: EdgeInsets.only(top:30),
              child:
                  Text('Settings',
                      style: TextStyle(fontSize: 30)
                  )
            )
            ,
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.green,
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text('Add phone numbers', style: TextStyle(color: Color(0xFF0D67B5)),),
                      );
                    },
                    body:Column(
                      children: <Widget>[
                        TextFormField(
                            maxLength: 30,
                            decoration: InputDecoration(
                                labelText: 'Phone number',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )
                            )
                        ),
                        TextFormField(
                            maxLength: 30,
                            decoration: InputDecoration(
                                labelText: 'Phone number',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )
                            )
                        ),
                        TextFormField(
                            maxLength: 30,
                            decoration: InputDecoration(
                                labelText: 'Phone number',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                )
                            )
                        )
                      ],
                    ),
                    isExpanded: _expanded,
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: Colors.grey,
                expansionCallback: (panelIndex, isExpanded) {
                  _expanded = !_expanded;
                  setState(() {

                  });
                },

              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, route.welcomePage, (Route<dynamic> route) => false);
                }, child: Text('Log out'))
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
        onTap: (index) =>  {if(index == 0) {
          Navigator.pushNamed(context, route.visualizationPage)
        }},
      ),);
  }
}
