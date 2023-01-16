#include <Arduino.h>
#include <SPIFFS.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <NTPClient.h>
#include <LiquidCrystal.h>
#include <Wire.h>
#include "soc/rtc.h"
#include "HX711.h"
#include <WiFiManager.h> // https://github.com/tzapu/WiFiManager

// Provide the token generation process info.
#include <addons/TokenHelper.h>

// select which pin will trigger the configuration portal when set to LOW
#define TRIGGER_PIN 34

int timeout = 120; // seconds to run for

//Essential global variables
bool isLeaked;//declare a variable to assign whether is a gas leakage or not
byte MQ6_Pin = A0;          /* Define A0 for MQ Sensor Pin */
float Referance_V = 3300.0; /* ESP32 Referance Voltage in mV */
float RL = 1.0;             /* In Module RL value is 1k Ohm */
float Ro = 10.0;            /* The Ro value is 10k Ohm */
float mVolt = 0.0;
const float Ro_clean_air_factor = 10.0;

//Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(19, 23, 18, 27, 26, 15);

// HX711 circuit wiring
const int LOADCELL_DOUT_PIN = 16;
const int LOADCELL_SCK_PIN = 4;


HX711 scale;

//Define buzzer connected pin
// #define BUZZER_PIN 18
#define LED_PIN 13


/* 2. Define the API Key */
#define API_KEY "XXXXXXXXX"

/* 3. Define the project ID */
#define FIREBASE_PROJECT_ID "XXXXXXX"



//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

bool signupOK = false;

//Timer variables (send new readings every two minutes)
unsigned long dataMillis = 0;
unsigned long timerDelay=60000;


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

bool checkLeakage(unsigned int lpg_ppm){
  if(lpg_ppm>3){
    return true;
  }else{
    return false;
  }
}



void setup() {
    WiFi.mode(WIFI_STA); // explicitly set mode, esp defaults to STA+AP
    // it is a good practice to make sure your code sets wifi mode how you want it.
 
    digitalWrite(LED_PIN,LOW);//turn off led initially
    // put your setup code here, to run once:
    Serial.begin(115200);

    Serial.println("\n Starting");
    pinMode(TRIGGER_PIN, INPUT_PULLUP);

    rtc_clk_apb_freq_update(RTC_CPU_FREQ_80M);
    scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
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
              
    scale.set_scale(-108.23);
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

    
    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    // Print a message to the LCD.
    lcd.setCursor(0, 0);
    lcd.print("Level:");
    lcd.setCursor(0, 1);
    lcd.print("LPG ppm:");

    pinMode(MQ6_Pin, INPUT);  /* Define A0 as a INPUT Pin */
    // pinMode(BUZZER_PIN,OUTPUT);/*Define pin 4 as OUTPUT Pin*/
    pinMode(LED_PIN,OUTPUT);/*Define pin 13 as OUTPUT Pin*/

    delay(500);
    Serial.println("Wait for 30 sec warmup");
    delay(30000);             /* Set the warmup delay wich is 30 Sec */
    Serial.println("Warmup Complete");
    for(int i=0; i<30; i++){
      mVolt += Get_mVolt(MQ6_Pin);
    }
    mVolt = mVolt /30.0;      /* Get the volatage in mV for 30 Samples */
    // Serial.print("Voltage at A0 Pin = ");
    // Serial.print(mVolt);
    // Serial.println("mVolt");
    // Serial.print("Rs = ");
    Serial.println(Calculate_Rs(mVolt));
    Ro = Calculate_Rs(mVolt) / Ro_clean_air_factor;
    // Serial.print("Ro = ");
    // Serial.println(Ro);
    // Serial.println(" ");
    mVolt = 0.0;

    // WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    // Serial.print("Connecting to Wi-Fi");
    // while (WiFi.status() != WL_CONNECTED){
    //   Serial.print(".");
    //   delay(300);
    // }
    // Serial.println();
    // Serial.print("Connected with IP: ");
    // Serial.println(WiFi.localIP());
    // Serial.println();


    // Initialize a NTPClient to get time
    timeClient.begin();
    timeClient.setTimeOffset(19800);

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;

    // /* Assign the user sign in credentials */
    // auth.user.email = USER_EMAIL;
    // auth.user.password = USER_PASSWORD;

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
    // Limit the size of response payload to be collected in FirebaseData
    // fbdo.setResponseSize(2048);
    // Firebase.begin(&config, &auth);

    /* Sign up */
    if (Firebase.signUp(&config, &auth, "", "")){
      Serial.println("ok");
      signupOK = true;
    }
    else{
      Serial.printf("%s\n", config.signer.signupError.message.c_str());
    }

    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
}

void loop(){
  // is configuration portal requested?
  if ( digitalRead(TRIGGER_PIN) == LOW) {
    WiFiManager wm;    
 
    //reset settings - for testing
    //wm.resetSettings();
  
    // set configportal timeout
    wm.setConfigPortalTimeout(timeout);
 
    if (!wm.startConfigPortal("OnDemandAP")) {
      Serial.println("failed to connect and hit timeout");
      delay(3000);
      //reset and try again, or maybe put it to deep sleep
      ESP.restart();
      delay(5000);
    }
 
    //if you get here you have connected to the WiFi
    Serial.println("connected...yeey :)");
 
  }
  
  
  Serial.print("one reading:\t");
  Serial.print(scale.get_units(), 1);
  Serial.print("\t| average:\t");
  Serial.println(scale.get_units(10), 5);
  lcd.setCursor(7,0);
  lcd.print(scale.get_units(10), 5);

  scale.power_down();             // put the ADC in sleep mode
  delay(5000);
  scale.power_up();

  for(int i=0; i<500; i++){
    mVolt += Get_mVolt(MQ6_Pin);
  }
  mVolt = mVolt/500.0;      /* Get the volatage in mV for 500 Samples */
  // Serial.print("Voltage at A0 Pin = ");
  // Serial.print(mVolt);      /* Print the mV in Serial Monitor */
  // Serial.println(" mV");

  float Rs = Calculate_Rs(mVolt);
  // Serial.print("Rs = ");
  // Serial.println(Rs);       /* Print the Rs value in Serial Monitor */
  float Ratio_RsRo = Rs/Ro;

  // Serial.print("RsRo = ");
  // Serial.println(Ratio_RsRo);

  Serial.print("LPG ppm = ");
  unsigned int LPG_ppm = LPG_PPM(Ratio_RsRo);
  Serial.println(LPG_ppm);   /* Print the Gas PPM value in Serial Monitor */
  isLeaked=checkLeakage(LPG_ppm);
  //set the cursor to column 0, line 1
  //(note: line 1 is the second row, since counting begins with 0):
  // print the number of seconds since reset:
  lcd.setCursor(9, 1);
  lcd.print(LPG_ppm);
 
  timeClient.update();
  String formattedTime = timeClient.getFormattedTime();

  //Get a time structure
  time_t epochTime = timeClient.getEpochTime();
  struct tm *ptm = gmtime ((time_t *)&epochTime); 

  //Print complete date:
  int monthDay = ptm->tm_mday;
  int currentMonth = ptm->tm_mon+1;
  int currentYear = ptm->tm_year+1900;
  String currentDate = String(currentYear) + "-" + String(currentMonth) + "-" + String(monthDay);

  // Firebase.ready() should be called repeatedly to handle authentication tasks.
  if (Firebase.ready() && signupOK && (millis() - dataMillis > timerDelay || dataMillis == 0)){
    dataMillis = millis();

    FirebaseJson content;
    
    // We will create the nested document in the parent path "gases/gas1"
    // gases is the collection id, gas1 is the document id in collection gases 
    String documentPath = "gases/gas0/0C:B8:15:EC:A8:94";

    // timestamp
    content.set("fields/Timestamp/stringValue", currentDate+" "+formattedTime); // RFC3339 UTC "Zulu" format

    //String
    content.set("fields/available/booleanValue",true);

    // integer
    content.set("fields/gasLevel/doubleValue", random(1, 500) / 100.0);

    // String doc_path = "projects/";
    // doc_path += FIREBASE_PROJECT_ID;
    // doc_path += "/databases/(default)/documents/gases/gas1"; // coll_id and doc_id are your collection id and document id


    // // reference
    // content.set("fields/myRef/referenceValue", doc_path.c_str());

    //String
    content.set("fields/Gasppm/stringValue",String(LPG_ppm));

    if(isLeaked){
      Serial.println("LPG gas leaked");
      content.set("fields/leakageStatus/booleanValue",true); 
      // digitalWrite(BUZZER_PIN,HIGH); //turn on the buzzer
      digitalWrite(LED_PIN,HIGH);//turn on led
      // delay(500);
      // digitalWrite(BUZZER_PIN, LOW);  //turn buzzer off
      // delay(500);
      lcd.setCursor(0, 1);
      lcd.print("Gas Leaked!");
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Level:");
      lcd.setCursor(0, 1);
      lcd.print("LPG ppm:");
    }else{
      content.set("fields/leakageStatus/booleanValue", false); 
      digitalWrite(LED_PIN,LOW);//turn off the led
    }

    Serial.print("Create document... ");
    if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID,"",documentPath.c_str(), content.raw())){
      Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
    }else{
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    mVolt = 0.0;              /* Set the mVolt variable to 0 */
  }
}

