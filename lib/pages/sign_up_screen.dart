import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:app/utilities/bluetooth.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();

}

class _signUpState extends State<signUp> {

  var response = "";

  void handleRegister() async{
    var loginResponse = await Provider.of<BluetoothConnection>(context, listen: false).user.register();

    if(loginResponse == "Register succesful."){
      setState(() {
        response = "";
      });
      Future.delayed(Duration(seconds: 2),() { Navigator.popAndPushNamed(context, route.signInPage); });
    }
    else{
      setState(() {
        response = loginResponse;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: ListView(
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 40),
                        child:
                        Image(image: AssetImage('assets/Car Accident detector-logos.jpeg'),
                          height: 250,
                          fit: BoxFit.fill,)
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child:
                        TextFormField(maxLength: 30,
                            onChanged: (text) {Provider.of<BluetoothConnection>(context, listen: false).user.setRegisterEmail(text);},
                            decoration: InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                  color: Color(0xFF0D67B5),
                                )
                            )
                        )
                    ),
                    Padding(
                        padding:EdgeInsets.only(left: 30, right: 30),
                        child:
                        TextFormField(
                            onChanged: (text) {Provider.of<BluetoothConnection>(context, listen: false).user.setRegisterPass(text);},
                            obscureText: true,
                            maxLength: 30,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Color(0xFF0D67B5),
                                )
                            )
                        )
                    ),
                    Padding(
                        padding:EdgeInsets.only(left: 30, right: 30, bottom: 30),
                        child:
                        TextFormField(
                            onChanged: (text) {Provider.of<BluetoothConnection>(context, listen: false).user.setRegisterConfirmPass(text);},
                            obscureText: true,
                            maxLength: 30,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                  color: Color(0xFF0D67B5),
                                )
                            )
                        )
                    ),
                    ElevatedButton(onPressed: () {
                      handleRegister();
                      },
                        child: Text('Sign Up')),
                    Text(
                        response, style: const TextStyle(color: Colors.red)
                    )
                  ]
              )]
        )

    );
  }
}