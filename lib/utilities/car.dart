
class Car {
  var vin;
  var model;
  late int speed;
  var passengers;

  Car(){
    this.speed = 0;
  }

  int getSpeed(){
    if(this.speed == null){
      return 0;
    }
    else{
      return this.speed;
    }
  }

  void setSpeed(speed) {
    this.speed = int.tryParse(speed) ?? 0;
  }
}