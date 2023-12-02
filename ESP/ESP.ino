#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>


#define WIFI_SSID "Tai"
#define WIFI_PASSWORD "01092003"
#define FIREBASE_HOST "fir-test-ffd86-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "DoeLJVdRfZsbkovgQcOBOxvstTEWAT45SsJhI6uI"

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
  if (Serial.available() > 0) {
    String c = Serial.readString();
    int vt = c.indexOf(":");
    String key = c.substring(0, vt);
    String value = c.substring(vt + 1);
    key.trim();
    value.trim();
    bool boolvalue=value.equalsIgnoreCase("true");
    Firebase.setBool(firebaseData, key, bool(value));
  }

  // Thêm các hành động khác cần thiết cho ESP8266 ở đây
}