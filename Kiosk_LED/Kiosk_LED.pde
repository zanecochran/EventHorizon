// Event Horizon Kiosk Finite State Machine (Arduino Comm)

import processing.serial.*;
Serial arduino;  // Connect to Arduino
int mode;        // Data received from the serial port

void setup(){
  size(500, 500);
  initSerial();
}

void draw(){
  background(0);
  
  if(mousePressed){
    mode = (mode + 1) % 6;
    int m = mode + 48;
    arduino.write(char(m));
    /*
    switch(mode){
      case 0: arduino.write('0'); break;
      case 1: arduino.write('1'); break;
      case 2: arduino.write('2'); break;
      case 3: arduino.write('3'); break;
      case 4: arduino.write('4'); break;
      case 5: arduino.write('5'); break;
    }
    */
    println("Sending: " + char(m));
    delay(250);
  }
}

// Initializes Serial Communication with Arduino
void initSerial(){
  printArray(Serial.list());
  String portName = Serial.list()[1];
  arduino = new Serial(this, portName, 9600);
}
