import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';

class User {
  var loginEmail = "";
  var loginPassword = "";
  var registerEmail = "";
  var registerPassword = "";
  var registerConfirmPassword = "";
  var token;

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
          this.token = decJson["id"];
        }
        print(this.token);
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
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
        return response;
      });
    }
    catch(error) {
      print("Chyba$error");
    }

    if(response.statusCode == 201) {
      return "Register succesful.";
    }
    else{
      return "Register unsuccesful.";
    }
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
}