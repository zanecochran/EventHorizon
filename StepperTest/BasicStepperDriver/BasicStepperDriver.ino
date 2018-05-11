
#include <Arduino.h>
#include "BasicStepperDriver.h"
#include <OneWire.h>
#include <DallasTemperature.h>

#define MOTOR_STEPS 200
#define RPM 120


#define MICROSTEPS 1


#define DIR 8
#define STEP 9
#define ENABLE 13

BasicStepperDriver stepper(MOTOR_STEPS, DIR, STEP, ENABLE);
#define ONE_WIRE_BUS 2
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

void setup() {
    stepper.begin(RPM, MICROSTEPS);
    sensors.begin();

    Serial.begin(9600);
}

void loop() {
    //sensors.requestTemperatures();
    //float t = ((sensors.getTempCByIndex(0)) * (9.0/5.0)) + 32;
    //Serial.println(t);
    Serial.print(" : ");
    int raw = analogRead(1);
    Serial.print(raw);
    Serial.print(" : ");
    if (raw < 300){
      stepper.enable();
      stepper.move(1);
      Serial.println("Up");
    }
    else if (raw > 700){
      stepper.enable();
      stepper.move(-1);
      Serial.println("Down");
    }
    else{
      stepper.disable();
      Serial.println("Off");
    }
    delay(10);

}
