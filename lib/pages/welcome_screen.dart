import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;

class welcome extends StatelessWidget {
    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/Car Accident detector-logos.jpeg')),
            Text('Welcome'),
            OutlinedButton(onPressed: () => Navigator.pushNamed(context, route.signInPage), child: Text('Sign in')),
            ElevatedButton(onPressed: () {

            }, child: Text('Sign up'))
          ]
        ),

      );
    }
}