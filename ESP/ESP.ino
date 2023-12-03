#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>
char serialBuffer[64];
int bufferIndex = 0;
#define WIFI_SSID "Tai"
#define WIFI_PASSWORD "01092003"
#define FIREBASE_HOST "smarthome-f6a60-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "1cAj58eFBmPDA7jrCgw34rXhsPNm1PhPuwmFJF8g"

FirebaseData firebaseData;
String lastStatus = "";
bool stt_led_san = "";
bool stt_led_khach = "";
bool stt_led_hl = "";
bool stt_led_p1 = "";
bool stt_led_p2 = "";
bool stt_led_bep = "";
void setup() {
  Serial.begin(9600);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected: ");
  Serial.println(WiFi.localIP());


  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
}

void loop() {
  if (Firebase.getString(firebaseData, "/led_san")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_san != ledstatus)
      Serial.println("led_san: ${ledstatus}");
    stt_led_san = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }
if (Firebase.getString(firebaseData, "/led_khach")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_khach != ledstatus)
      Serial.println("led_khach: ${ledstatus}");
    stt_led_khach = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getString(firebaseData, "/led_hl")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_hl != ledstatus)
      Serial.println("led_hl: ${ledstatus}");
    stt_led_hl = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getString(firebaseData, "/led_bep")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_bep != ledstatus)
      Serial.println("led_bep: ${ledstatus}");
    stt_led_bep = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  // Đọc dữ liệu từ ATmega328P qua UART
  while (Serial.available() > 0) {
    char incomingChar = Serial.read();

    // Check for end of message
    if (incomingChar == '\n') {
      serialBuffer[bufferIndex] = '\0'; // Null-terminate the string
      String c = String(serialBuffer);

      // Check for the presence of ":"
      int vt = c.indexOf(":");
      if (vt != -1) {
        String key = c.substring(0, vt);
        String value = c.substring(vt + 1);
        key.trim();
        value.trim();


        bool boolvalue = (value.toInt() == 1);
        Firebase.setBool(firebaseData, key.c_str(), boolvalue);
      }

      // Reset bufferIndex for the next message
      bufferIndex = 0;
    } else {
      // Add character to the buffer if there is space
      if (bufferIndex < 64 - 1) {
        serialBuffer[bufferIndex++] = incomingChar;
      }
    }
  }

  // Thêm các hành động khác cần thiết cho ESP8266 ở đây
}