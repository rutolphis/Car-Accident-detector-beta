import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';

class Car {
  var vin = "-";
  late int speed = 0;
  late String rmp = "-";
  late String pedalPosition = "-";
  late String temperature = "-";
  late String rotationX = "-";
  late String rotationY = "-";
  late String rotationZ = "-";
  late String accelarationX = "-";
  late String accelarationY = "-";
  late String accelarationZ = "-";
  late double gforce = 0;
  bool dot1 = false;
  bool dot2 = false;
  bool dot3 = false;
  bool dot4 = false;
  bool dot5 = false;
  bool engineStatus = false;
  double lastRotation = 0;


  //accident data set
  var vinA = "-";
  late int speedA = 0;
  late String rmpA = "-";
  late String pedalPositionA = "-";
  late String temperatureA = "-";
  late double rotationXA;
  late double rotationYA;
  late double rotationZA;
  late double accelarationXA;
  late double accelarationYA;
  late double accelarationZA;
  late double gforceA = 0;
  bool dot1A = false;
  bool dot2A = false;
  bool dot3A = false;
  bool dot4A = false;
  bool dot5A = false;
  bool engineStatusA = false;
  late String impactSide = "-";
  int carPosition = 0;
  double impactAngle = 0;
  int rotationCount = 0;


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

  void accidentDataset(){
    this.vinA = this.vin;
    this.speedA = this.speed;
    this.rmpA = this.rmp;
    this.pedalPositionA = this.pedalPosition;
    this.temperatureA = this.temperature;
    this.rotationXA = double.tryParse(this.rotationX) ?? 0;
    this.rotationYA = double.tryParse(this.rotationY) ?? 0;
    this.rotationZA = double.tryParse(this.rotationZ) ?? 0;
    this.accelarationXA = double.tryParse(this.accelarationX) ?? 0;
    this.accelarationYA = double.tryParse(this.accelarationY) ?? 0;
    this.accelarationZA = double.tryParse(this.accelarationZ) ?? 0;
    this.gforceA = this.gforce;
    this.dot1A = this.dot1;
    this.dot2A = this.dot2;
    this.dot3A = this.dot3;
    this.dot4A = this.dot4;
    this.dot5A = this.dot5;
    this.engineStatusA = this.engineStatus;
  }

  void calImpactSide() {

    if(atan2(accelarationXA,accelarationYA) > 0){
      impactAngle = (180/pi) * atan2(accelarationXA,accelarationYA);
    }
    else {
      impactAngle = (180/pi) * (atan2(accelarationXA,accelarationYA)+2*pi);
    }

  }

  void calCarPosition() {
    if((double.tryParse(this.accelarationZ) ?? 0).abs() > (double.tryParse(this.accelarationX) ?? 0).abs()) {
      if ((double.tryParse(this.accelarationZ) ?? 0) > 0) {
        this.carPosition = 0;
      } else {
        this.carPosition = 2;
      }
    }
    else {
      if ((double.tryParse(this.accelarationX) ?? 0) > 0) {
        this.carPosition = 3;
      } else {
        this.carPosition = 1;
      }
    }
  }

  void calCarRotation() {
    bool done = false;
    double lastRotation = double.tryParse(this.accelarationZ) ?? 0;

    Future.delayed(Duration(seconds: 3), () {done = true;});

    Future.doWhile(() {
      if(done == false){
        if((double.tryParse(this.accelarationZ) ??
        0) > 0 && lastRotation < 0){
          this.rotationCount++;
      }
      } else {
        print("otocenie ${rotationCount}");
        return false;
    }
      return true;

    });

  }


}