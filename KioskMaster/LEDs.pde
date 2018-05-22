// Control Interface for Arduino-connected NeoPixels
// LEDs help the user understand what current program they are running

import processing.serial.*;
Serial arduino;  // Arduino Serial Connection


// Initializes Serial Communication with Arduino
void initSerial(){
  printArray(Serial.list());
  String portName = Serial.list()[1];
  arduino = new Serial(this, portName, 9600);
}

// Receives a mode and sends it to the Arduino to display the appropriate color
void sendLED(int m){
  m += 48;
  arduino.write(char(m));
  if(debug){println("Sending Arduino: " + char(m));}
}
