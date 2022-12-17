#include <Arduino.h>
#include <SPIFFS.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <NTPClient.h>
// Provide the token generation process info.
#include <addons/TokenHelper.h>


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

/* 1. Define the WiFi credentials */
#define WIFI_SSID "XXXXXXX"
#define WIFI_PASSWORD "XXXXXX"

/* 2. Define the API Key */
#define API_KEY "XXXXXX"

/* 3. Define the project ID */
#define FIREBASE_PROJECT_ID "XXXXXXX"

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "XXXXXXX@gmail.com"
#define USER_PASSWORD "XXXXXXX"

//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

//Timer variables (send new readings every two minutes)
unsigned long dataMillis = 0;
unsigned long timerDelay=120000;


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
  if(lpg_ppm>200){
    return true;
  }else{
    return false;
  }
}

void setup() {
    // put your setup code here, to run once:
    Serial.begin(115200);
    pinMode(MQ6_Pin, INPUT);  /* Define A0 as a INPUT Pin */
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

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED){
      Serial.print(".");
      delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    // Initialize a NTPClient to get time
    timeClient.begin();
    timeClient.setTimeOffset(19800);

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;

    /* Assign the user sign in credentials */
    auth.user.email = USER_EMAIL;
    auth.user.password = USER_PASSWORD;

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
    // Limit the size of response payload to be collected in FirebaseData
    // fbdo.setResponseSize(2048);
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
}

void loop(){
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

  // Serial.print("LPG ppm = ");
  unsigned int LPG_ppm = LPG_PPM(Ratio_RsRo);
  // Serial.println(LPG_ppm);   /* Print the Gas PPM value in Serial Monitor */
  isLeaked=checkLeakage(LPG_ppm);
 
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
  if (Firebase.ready() && (millis() - dataMillis > timerDelay || dataMillis == 0)){
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

 
    if(isLeaked){
      Serial.println("LPG gas leaked");
      content.set("fields/leakageStatus/booleanValue",true); 
    }else{
       content.set("fields/leakageStatus/booleanValue", false); 
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
