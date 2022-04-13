import 'package:flutter/material.dart';
import 'package:app/route/route.dart' as route;

class welcome extends StatelessWidget {
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
            Text('Welcome',
              style: TextStyle(fontSize: 30)
            ),
            Padding(
              padding:EdgeInsets.only(top: 40, bottom: 20),
              child:
                OutlinedButton(onPressed: () { Navigator.pushNamed(context, route.signInPage);}, child: Text('Sign in'))
            ),
            ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, route.signUpPage);
            }, child: Text('Sign up'))
          ]
        ),]

      ));
    }
}