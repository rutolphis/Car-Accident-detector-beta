import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;

class signIn extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/Car Accident detector-logos.jpeg')),
            TextFormField(
              maxLength: 30,
              decoration: InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(
              color: Color(0xFF0D67B5),
            ))),
            TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFF0D67B5),
                    ))),
            ElevatedButton(onPressed: () => Navigator.pushNamed(context, route.connectPage),
            child: Text('Sign In'))
          ]
      ),

    );
  }
}