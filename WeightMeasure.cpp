/*
 * Complete project details at https://RandomNerdTutorials.com/esp32-load-cell-hx711/
 *
 * HX711 library for Arduino - example file
 * https://github.com/bogde/HX711
 *
 * MIT License
 * (c) 2018 Bogdan Necula
 *
**/
#include <Arduino.h>
#include "HX711.h"
#include "soc/rtc.h"

// HX711 circuit wiring
const int LOADCELL_DOUT_PIN = 16;
const int LOADCELL_SCK_PIN = 4;

HX711 scale;

void setup() {
  Serial.begin(115200);
  rtc_clk_cpu_freq_set(RTC_CPU_FREQ_80M);
  Serial.println("HX711 Demo");

  Serial.println("Initializing the scale");

  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);

  Serial.println("Before setting up the scale:");
  Serial.print("read: \t\t");
  Serial.println(scale.read());      // print a raw reading from the ADC

  Serial.print("read average: \t\t");
  Serial.println(scale.read_average(20));   // print the average of 20 readings from the ADC

  Serial.print("get value: \t\t");
  Serial.println(scale.get_value(5));   // print the average of 5 readings from the ADC minus the tare weight (not set yet)

  Serial.print("get units: \t\t");
  Serial.println(scale.get_units(5), 1);  // print the average of 5 readings from the ADC minus tare weight (not set) divided
            // by the SCALE parameter (not set yet)
            
  scale.set_scale(958.1625);
  //scale.set_scale(-471.497);                      // this value is obtained by calibrating the scale with known weights; see the README for details
  scale.tare();               // reset the scale to 0

  Serial.println("After setting up the scale:");

  Serial.print("read: \t\t");
  Serial.println(scale.read());                 // print a raw reading from the ADC

  Serial.print("read average: \t\t");
  Serial.println(scale.read_average(20));       // print the average of 20 readings from the ADC

  Serial.print("get value: \t\t");
  Serial.println(scale.get_value(5));   // print the average of 5 readings from the ADC minus the tare weight, set with tare()

  Serial.print("get units: \t\t");
  Serial.println(scale.get_units(5), 1);        // print the average of 5 readings from the ADC minus tare weight, divided
            // by the SCALE parameter set with set_scale

  Serial.println("Readings:");
}

void loop() {
  Serial.print("one reading:\t");
  Serial.print(scale.get_units(), 1);
  Serial.print("\t| average:\t");
  Serial.println(scale.get_units(10), 5);

  scale.power_down();             // put the ADC in sleep mode
  delay(5000);
  scale.power_up();
}
