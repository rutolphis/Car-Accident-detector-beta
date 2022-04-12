import 'package:http/http.dart';

class User {
  var loginEmail = "";
  var loginPassword = "";
  var registerEmail = "";
  var registerPassword = "";
  var registerConfirmPassword = "";
  var token;

  String login(){
    if(this.loginEmail == "" || this.loginPassword == ""){
      return "All fields have to be filled.";
    }
    if(true) {
      return "Login succesful.";
    }
    else{
      return "login unsuccesful.";
    }
  }

  String register(){
    if(this.registerEmail == "" || this.registerPassword == "" || this.registerConfirmPassword == ""){
      return "All fields have to be filled.";
    }

    if(true) {
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
    this.registerEmail=email;
  }

  void setRegisterPass(password){
    this.registerPassword=password;
  }

  void setRegisterConfirmPass(password){
    this.registerConfirmPassword=password;
  }
}