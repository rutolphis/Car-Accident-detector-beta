import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:app/route/route.dart' as route;

class User {
  var loginEmail = "";
  var loginPassword = "";
  var registerEmail = "";
  var registerPassword = "";
  var registerConfirmPassword = "";
  var token;
  var numberOne = "";
  var numberTwo = "";
  var numberThree = "";

  Future<String> login() async{
    var response;
    if(this.loginEmail == "" || this.loginPassword == ""){
      return "All fields have to be filled.";
    }

    final uri = Uri.parse('https://bakalarka-app.herokuapp.com/api/bakalarka/users/login');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = { "email":this.loginEmail,"password":this.loginPassword};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).then((response) {
        var decJson = jsonDecode(response.body);
        if(decJson.containsKey("id")){
          this.token = decJson["id"].toString();
        }
        print(this.token);
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
      return Future.value("login unsuccesful.");
    }

    if(response.statusCode == 200) {
      return Future.value("Login succesful.");
    }
    else{
      return Future.value("login unsuccesful.");
    }
  }

  Future<String> register() async{

    var response;
    if(this.registerEmail == "" || this.registerPassword == "" || this.registerConfirmPassword == ""){
      return "All fields have to be filled.";
    }
    if(this.registerPassword != this.registerConfirmPassword) {
      return "Passwords have to be matching.";
    }

    final uri = Uri.parse('https://bakalarka-app.herokuapp.com/api/bakalarka/users');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = { "email":this.registerEmail,"password":this.registerPassword};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      response = await post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).then((response) {
        print(response.body);
        this.registerEmail = "";
        this.registerPassword = "";
        this.registerConfirmPassword = "";
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
      return "Register unsuccesful.";
    }

    if(response.statusCode == 201) {
      return "Register succesful.";
    }
    else{
      return "Register unsuccesful.";
    }
  }

  Future<String> editNumbers() async {
    final uri;
    var response;
    if(this.token != null) {
      uri = Uri.parse(
          'https://bakalarka-app.herokuapp.com/api/bakalarka/users/${this.token}');
    }
    else{
      return "Token is missing! Try to log out and sign in again.";
    }

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = { "phone_numbers": [this.numberOne,this.numberTwo,this.numberThree]};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      response = await put(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).then((response) {
        print(response.body);
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
    }

    return "Succesfully inserted.";
  }

  Future<bool> getNumbers() async {

    final uri;
    var response;
    if(this.token != null) {
      uri = Uri.parse(
          'https://bakalarka-app.herokuapp.com/api/bakalarka/users/${this.token}/phone_numbers');
    }
    else{
      return Future.value(false);
    }

    final headers = {'Content-Type': 'application/json'};

    try {
      response = await get(
        uri,
        headers: headers,
      ).then((response) {
        print(response.body);
        var decJson = jsonDecode(response.body);
        if(decJson != null){
          setNumberOne(decJson[0]);
          setNumberTwo(decJson[1]);
          setNumberThree(decJson[2]);
        }
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
      return Future.value(false);
    }

    return Future.value(true);
  }

  void logOut() {
    this.loginEmail = "";
    this.loginPassword = "";
    this.token = null;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(route.welcomePage, (Route<dynamic> route) => false);
  }


  void setLoginEmail(email){
    this.loginEmail = email;
  }
  void setLoginPass(password){
    this.loginPassword = password;
  }

  void setRegisterEmail(email){
    this.registerEmail = email;
  }

  void setRegisterPass(password){
    this.registerPassword=password;
  }

  void setRegisterConfirmPass(password){
    this.registerConfirmPassword=password;
  }

  void setNumberOne(number) {
    this.numberOne = number;
  }

  void setNumberTwo(number) {
    this.numberTwo = number;
  }

  void setNumberThree(number) {
    this.numberThree = number;
  }

  String getNumberOne() {
    return this.numberOne.toString();
  }

  String getNumberTwo() {
    return this.numberTwo.toString();
  }

  String getNumberThree() {
    return this.numberThree.toString();
  }

}