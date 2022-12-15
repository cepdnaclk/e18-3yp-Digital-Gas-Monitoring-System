#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <NTPClient.h>

// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

/* 1. Define the WiFi credentials */
#define WIFI_SSID "XXXXXXXX"
#define WIFI_PASSWORD "XXXXXXXX"

/* 2. Define the API Key */
#define API_KEY "XXXXXXXXXXXXX"

/* 3. Define the project ID */
#define FIREBASE_PROJECT_ID "XXXXXXXXXXXXXXX"

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "XXXX@gmail.com"
#define USER_PASSWORD "XXXXXXXXXXXX"

//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

//Timer variables (send new readings every two minutes)
unsigned long dataMillis = 0;
unsigned long timerDelay=120000;

int count=0;
void setup() {
  // put your setup code here, to run once:
   Serial.begin(115200);
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
    String documentPath = "gases/gas0/gas";

    // integer
    content.set("fields/myInteger/integerValue", String(random(500, 1000)));

    // String doc_path = "projects/";
    // doc_path += FIREBASE_PROJECT_ID;
    // doc_path += "/databases/(default)/documents/gases/gas1"; // coll_id and doc_id are your collection id and document id


    // // reference
    // content.set("fields/myRef/referenceValue", doc_path.c_str());

    // timestamp
    content.set("fields/Timestamp/stringValue", currentDate+" "+formattedTime); // RFC3339 UTC "Zulu" format


    Serial.print("Create document... ");
    if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID,"",documentPath.c_str(), content.raw())){
      Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
    }else{
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
  }
  count++;
  
}
