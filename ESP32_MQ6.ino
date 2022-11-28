/*
  ESP32 MQ6 LPG Gas and PPM Calculation
*/

#include "Arduino.h"


byte MQ6_Pin = A0;          /* Define A0 for MQ Sensor Pin */
float Referance_V = 3300.0; /* ESP32 Referance Voltage in mV */
float RL = 1.0;             /* In Module RL value is 1k Ohm */
float Ro = 10.0;            /* The Ro value is 10k Ohm */
float mVolt = 0.0;
const float Ro_clean_air_factor = 10.0;

void setup() {
  Serial.begin(9600);       /* Set baudrate to 9600 */
  pinMode(MQ6_Pin, INPUT);  /* Define A0 as a INPUT Pin */
  delay(500);
  Serial.println("Wait for 30 sec warmup");
  delay(30000);             /* Set the warmup delay wich is 30 Sec */
  Serial.println("Warmup Complete");

  for(int i=0; i<30; i++){
    mVolt += Get_mVolt(MQ6_Pin);
  }
  mVolt = mVolt /30.0;      /* Get the volatage in mV for 30 Samples */
  Serial.print("Voltage at A0 Pin = ");
  Serial.print(mVolt);
  Serial.println("mVolt");
  Serial.print("Rs = ");
  Serial.println(Calculate_Rs(mVolt));
  Ro = Calculate_Rs(mVolt) / Ro_clean_air_factor;
  Serial.print("Ro = ");
  Serial.println(Ro);
  Serial.println(" ");
  mVolt = 0.0;
}

void loop() {
  for(int i=0; i<500; i++){
    mVolt += Get_mVolt(MQ6_Pin);
  }
  mVolt = mVolt/500.0;      /* Get the voltage in mV for 500 Samples */
  Serial.print("Voltage at A0 Pin = ");
  Serial.print(mVolt);      /* Print the mV in Serial Monitor */
  Serial.println(" mV");

  float Rs = Calculate_Rs(mVolt);
  Serial.print("Rs = ");
  Serial.println(Rs);       /* Print the Rs value in Serial Monitor */
  float Ratio_RsRo = Rs/Ro;

  Serial.print("RsRo = ");
  Serial.println(Ratio_RsRo);

  Serial.print("LPG ppm = ");
  unsigned int LPG_ppm = LPG_PPM(Ratio_RsRo);
  Serial.println(LPG_ppm);   /* Print the Gas PPM value in Serial Monitor */
  
  Serial.println("");
  mVolt = 0.0;              /* Set the mVolt variable to 0 */
}


float Calculate_Rs(float Vo) {
/* 
 *  Calculate the Rs value
 *  The equation Rs = (Vc - Vo)*(RL/Vo)
 */
  float Rs = (Referance_V - Vo) * (RL / Vo);  
  return Rs;
}


unsigned int LPG_PPM(float RsRo_ratio) {
/*
 * Calculate the PPM using below equation
 * LPG ppm = [(Rs/Ro)/18.446]^(1/-0.421)
 */
  float ppm;
  ppm = pow((RsRo_ratio/18.446), (1/-0.421));
  return (unsigned int) ppm;
}


float Get_mVolt(byte AnalogPin) {
/* Calculate the ADC Voltage using below equation
 *  mVolt = ADC_Count * (ADC_Referance_Voltage / ADC_Resolution)
 */
  int ADC_Value = analogRead(AnalogPin);  
  delay(1);
  float mVolt = ADC_Value * (Referance_V / 4096.0);
  return mVolt;
}
