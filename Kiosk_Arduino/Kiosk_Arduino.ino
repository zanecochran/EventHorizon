#include <Adafruit_NeoPixel.h>
Adafruit_NeoPixel strip = Adafruit_NeoPixel(75, 6, NEO_GRB + NEO_KHZ800);

int leds = 75;
int mode = 0;
int lastMode = -1;
char val;
int transSize = 10;

void setup() {
  Serial.begin(9600);
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
  Serial.println("System Ready");
}

void loop() {

  while (Serial.available()) {val = Serial.read(); Serial.println(val);}
  if (val == '0') {mode = 0;}
  if (val == '1') {mode = 1;}
  if (val == '2') {mode = 2;}
  if (val == '3') {mode = 3;}
  if (val == '4') {mode = 4;}
  if (val == '5') {mode = 5;}
  
  switch(mode){
    case 0: strandColor(255, 0, 0); break;     // Start Up/Calibration
    case 1: strandColor(0, 255, 0); break;     // Neutral
    case 2: strandColor(0, 0, 255); break;     // User Topo
    case 3: strandColor(255, 0, 255); break;   // User Draw
    case 4: strandColor(255, 255, 0); break;   // System Wave
    case 5: strandColor(0, 255, 255); break;   // System Video    
    Serial.println(mode);
  }

  if (mode != lastMode){
    transition();
    lastMode = mode;
  }

  strip.show();

}

void transition(){
  for (int i = 0; i < leds; i++){
    strandColor(0, 0, 0);
    for (int j = 0; j < transSize; j++){
      switch(mode){
        case 0: strip.setPixelColor(i + j, 255, 0, 0); break;
        case 1: strip.setPixelColor(i + j, 0, 255, 0); break;
        case 2: strip.setPixelColor(i + j, 0, 0, 255); break;
        case 3: strip.setPixelColor(i + j, 255, 0, 255); break;
        case 4: strip.setPixelColor(i + j, 255, 255, 0); break;
        case 5: strip.setPixelColor(i + j, 0, 255, 255); break;
      }
    }
    strip.show();
    delay(10);
  }
}

void strandColor(int r, int g, int b){
  for (int i = 0; i < leds; i++){
    strip.setPixelColor(i, r, g, b);  
  }
}

