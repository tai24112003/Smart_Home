#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>

char serialBuffer[64];
int bufferIndex = 0;

#define WIFI_SSID "Tai"
#define WIFI_PASSWORD "01092003"
#define FIREBASE_HOST "smarthome-f6a60-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "1cAj58eFBmPDA7jrCgw34rXhsPNm1PhPuwmFJF8g"

FirebaseData firebaseData;
bool stt_led_san = false;
bool stt_led_khach = false;
bool stt_led_hl = false;
bool stt_led_p1 = false;
bool stt_led_p2 = false;
bool stt_led_bep = false;
bool stt_servo = false;
bool system_lock = true;
bool baodong =false;
int stt_ngu1 = 0;
int stt_ngu2 = 0;

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
  if (Firebase.getBool(firebaseData, "/led_san")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_san != ledstatus)
      Serial.println("led_san: " + String(ledstatus));
    stt_led_san = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }

  if (Firebase.getBool(firebaseData, "/led_khach")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_khach != ledstatus)
      Serial.println("led_khach: " + String(ledstatus));
    stt_led_khach = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }

  if (Firebase.getBool(firebaseData, "/led_hl")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_hl != ledstatus)
      Serial.println("led_hl: " + String(ledstatus));
    stt_led_hl = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }

  if (Firebase.getBool(firebaseData, "/led_bep")) {
    bool ledstatus = firebaseData.boolData();
    if (stt_led_bep != ledstatus)
      Serial.println("led_bep: " + String(ledstatus));
    stt_led_bep = ledstatus;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getBool(firebaseData, "/servo")) {
    bool servo = firebaseData.boolData();
    if (stt_servo != servo)
      Serial.println("servo: " + String(servo));
    stt_servo = servo;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getInt(firebaseData, "/led_ngu1")) {
    int servo = firebaseData.intData();
    if (stt_ngu1 != servo)
      Serial.println("led_ngu1: " + String(servo));
    stt_ngu1 = servo;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getInt(firebaseData, "/led_ngu2")) {
    int servo = firebaseData.intData();
    if (stt_ngu2 != servo)
      Serial.println("led_ngu2: " + String(servo));
    stt_ngu2 = servo;
    // Gửi dữ liệu về ATmega328P qua UART
  }

  if (Firebase.getBool(firebaseData, "/system_lock")) {
    int servo = firebaseData.boolData();
    if (system_lock != servo)
      Serial.println("system_lock: " + String(servo));
    system_lock = servo;
    // Gửi dữ liệu về ATmega328P qua UART
  }
  if (Firebase.getBool(firebaseData, "/baodong")) {
    int servo = firebaseData.boolData();
    if (baodong != servo)
      Serial.println("baodong: " + String(servo));
    baodong = servo;
    // Gửi dữ liệu về ATmega328P qua UART
  }

  // Đọc dữ liệu từ ATmega328P qua UART
  while (Serial.available() > 0) {
    char incomingChar = Serial.read();

    // Check for end of message
    if (incomingChar == '\n') {
      serialBuffer[bufferIndex] = '\0';  // Null-terminate the string
      String c = String(serialBuffer);

      // Check for the presence of ":"
      int vt = c.indexOf(":");
      if (vt != -1) {
        String key = c.substring(0, vt);
        String value = c.substring(vt + 1);
        key.trim();
        value.trim();


        bool boolvalue = (value.toInt() == 1);
        int intValue = value.toInt();
        if (!key.equals("led_ngu1")&&!key.equals("led_ngu2"))
          Firebase.setBool(firebaseData, key.c_str(), boolvalue);
        else
          Firebase.setInt(firebaseData, key.c_str(), intValue);
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
}

// Thêm các hành động khác cần thiết cho ESP8266 ở đây
