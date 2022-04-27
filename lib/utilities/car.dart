import 'dart:core';
import 'dart:math';

class Car {
  var vin = "-";
  late int speed = 0;
  late String rmp = "-";
  late String pedalPosition = "-";
  late String temperature = "-";
  late String rotationX = "";
  late String rotationY = "";
  late String rotationZ = "";
  late String accelarationX = "";
  late String accelarationY = "";
  late String accelarationZ = "";
  late double gforce = 0;
  bool dot1 = true;
  bool dot2 = true;
  bool dot3 = true;
  bool dot4 = true;
  bool dot5 = true;
  bool engineStatus = false;

  Car(){
  }


  String getVin(){
    if(this.vin != null) {
      return this.vin;
    }
    else{
      return "";
    }
  }

  int getSpeed(){
    if(this.speed == null){
      return 0;
    }
    else{
      return this.speed;
    }
  }

  void setSpeed(data) {
    this.speed = int.tryParse(data) ?? 0;
  }

  void setPedalPosition(data) {
    this.pedalPosition = data;
  }

  void setVin(data) {
    this.vin = data;
  }

  void setTemperature(data) {
    this.temperature = data;
  }

  String getTemperature(){
    return this.temperature;
  }

  void setRotationX(data) {
    this.rotationX = data;
  }

  void setRotationY(data) {
    this.rotationY = data;
  }

  void setRotationZ(data) {
    this.rotationZ = data;
  }

  void setAccelerationX(data) {
    this.accelarationX = data;
  }

  void setAccelerationY(data) {
    this.accelarationY = data;
  }

  void setAccelerationZ(data) {
    this.accelarationZ = data;
  }

  String getPedalPosition(){
    if(pedalPosition != null){
      return pedalPosition;
    }
    else {
      return "";
    }
  }

  void setDots(data) {

    if(data[0] == '1'){
      dot1 = true;
    }
    else{
      dot1 = false;
    }

    if(data[1] == '1'){
      dot2 = true;
    }
    else{
      dot2 = false;
    }

    if(data[2] == '1'){
      dot3 = true;
    }
    else{
      dot3 = false;
    }
    if(data[3] == '1'){
      dot4 = true;
    }
    else{
      dot4 = false;
    }

    if(data[4] == '1'){
      dot5 = true;
    }
    else{
      dot5 = false;
    }

  }

  String getRotationX(data) {
    return this.rotationX;
  }

  String getRotationY(data) {
    return this.rotationY;
  }

  String getRotationZ(data) {
    return this.rotationZ;
  }

  String getAccelerationX(data) {
    return this.accelarationX;
  }

  String getAccelerationY(data) {
    return this.accelarationY;
  }

  String getAccelerationZ(data) {
    return this.accelarationZ;
  }

  void setRmp(data) {
    this.rmp = data;
  }

  String getRmp() {
    return this.rmp;
  }

  int getSeats() {
    int count = 0;
    if(dot1 == true){
      count++;
    }
    if(dot2 == true){
      count++;
    }

    if(dot3 == true){
      count++;
    }

    if(dot4 == true){
      count++;
    }

    if(dot5 == true){
      count++;
    }

    return count;
  }

  void calculateG(x,y,z){
    this.gforce = sqrt(x * x + y * y + z * z);
  }

  double getGForce(){
    return this.gforce;
  }

  void setEngineStatus(){
    int rpmInt = int.tryParse(this.rmp) ?? 0;
    if(rpmInt > 0){
      this.engineStatus = true;
    }
    else {
      this.engineStatus = false;
    }
  }

  bool getEngineStatus() {
    return engineStatus;
  }

}