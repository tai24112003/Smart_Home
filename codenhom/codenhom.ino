#include <LiquidCrystal_I2C.h>
#include <Servo.h>
Servo myservo;
LiquidCrystal_I2C lcd(0X27, 16, 2);
unsigned long t_high = 0;
unsigned long t_high2 = 0;
unsigned long t_low = 0;
String pass = "1010";
String pass_in = "";
bool system_lock = false;
String receivedChar;
short pass_wrong = 0;
short btn_pass = 2;
//led system
short btn_toilet = 0;
// short led_toilet = 1;
short btn_san_khach = 3;
//short btn_hl_bep = 4;
short servo = 4;

short btn_p1 = 5;
short btn_p2 = 6;
short btn_baodong = 7;
//short btn_toilet=6;
short led_san = 8;
short led_khach = 9;
short led_hl = 12;
short led_p1 = 11;
short led_p2 = 10;
short led_bep = 13;
//short led_toilet=13;
//Status
bool stt_btn_san_khach = false;
bool stt_btn_hl = false;
bool stt_btn_p1 = false;
bool stt_btn_p2 = false;
bool stt_btn_baodong = false;
bool stt_toilet = false;
bool stt_led_san = LOW;
bool stt_led_khach = LOW;
bool stt_led_hl = LOW;
bool stt_led_p1 = LOW;
bool stt_led_p2 = LOW;
bool stt_led_bep = LOW;


int dosang=0;
int dosang2 =0;

bool stt_servo = false;
unsigned long time_quay = 0;

short led_san_khach = 0;
short led_p1_hl = 0;
short led_p2_hl = 0;
short led_hl_bep = 0;
bool baodong = false;


//LCD
short col = 0;
unsigned long time_open = 0;
void setup() {
  Serial.begin(9600);
  lcd.init();
  lcd.backlight();
  myservo.attach(4);
  // pinMode(btn_toilet, INPUT);
  pinMode(btn_san_khach, INPUT);
  //  pinMode(btn_hl_bep, INPUT);
  pinMode(btn_p1, INPUT);
  pinMode(btn_p2, INPUT);
  pinMode(btn_pass, INPUT);
  pinMode(btn_baodong, INPUT);
  pinMode(led_san, OUTPUT);
  pinMode(led_khach, OUTPUT);
  pinMode(led_hl, OUTPUT);
  pinMode(led_p1, OUTPUT);
  pinMode(led_p2, OUTPUT);
  pinMode(led_bep, OUTPUT);
  //  pinMode(led_toilet, OUTPUT);
}

void loop() {
  unsigned long t_cur = millis();
  int btn_cur_stt = digitalRead(btn_pass);
  while (Serial.available() > 0) {
    receivedChar = Serial.readString();
    // Xử lý dữ liệu từ ESP8266 (ví dụ: in ra Serial Monitor)
    int vt = receivedChar.indexOf(":");
    String key = receivedChar.substring(0, vt);
    String value = receivedChar.substring(vt + 1);
    key.trim();
    value.trim();
    
    if(key == "led_ngu1") dosang = value.toInt();
    bool boolvalue;

    analogWrite()
    boolvalue = value == "1";
    if (key.equals("led_san"))
      stt_led_san = boolvalue;
    else if (key.equals("led_khach"))
      stt_led_khach = boolvalue;
    else if (key.equals("led_hl"))
      stt_led_hl = boolvalue;
    else if (key.equals("led_bep"))
      stt_led_bep = boolvalue;
    else if (key.equals("servo")) 
      stt_servo = boolvalue;
    else if(key.equals("led_ngu1"))
      dosang = value.toInt();
    else if(key.equals("led_ngu2"))
      dosang2 = value.toInt();

    
  }
  system_lock = false; 
  switch (system_lock) {
    case true:
      // Serial.print(digitalRead(btn_toilet));
      lcd.setCursor(0, 0);
      lcd.print("Khoa He Thong")
      if (btn_cur_stt == 1) {

        if (t_high == 0)
        //Truoc do chua high gio bat dau high-->bat dau thao tac
        {
          t_high = t_cur;
        } else if (t_low != 0 && t_high2 == 0)
        //da high xong lan 1 (co t_low), high lan 2
        {
          t_high2 = t_cur;
        }
      } else {
        if (t_high2 != 0 && t_cur - t_high <= 1000)
        //da high lan 2 va thoi gian <= 1s
        {
          t_high = 0;
          t_high2 = 0;
          t_low = 0;
          pass_in += "1";
          lcd.clear();

          //          Serial.println(pass_in);

        } else {
          if (t_high != 0 && t_cur - t_high > 1000)
          //da high lan 1 va thoi gian > 1000
          {

            t_high = 0;
            t_high2 = 0;
            t_low = 0;
            pass_in += "0";
            lcd.clear();

            //            Serial.println(pass_in);

          } else {
            if (t_high != 0)
            //Neu da co high thi moi cap nhat t_low
            {
              t_low = t_cur;
            }
          }
        }
      }
      if (pass_in.length() == pass.length()) {
        if (pass == pass_in) {
          pass_in = "";
          //          Serial.println("Voo he thong nha ni");
          time_open = millis();
          system_lock = false;
        } else {
          lcd.setCursor(0, 1);
          lcd.print("Sai MK");

          pass_wrong++;
          pass_in = "";
          //          Serial.println("Sai r ni oi");
          // Serial.println(pass_wrong);
        }
      }
      if (pass_wrong > 2) {
        //Xử lí chơp đèn
        if (millis() % 50 == 0) {
          digitalWrite(led_san, !digitalRead(led_san));
        }
        // Serial.println("Chop den thoai");
        if (pass_in.length() == pass.length()) {
          if (pass == pass_in) {
            pass_in = "";
            system_lock = false;
            //            Serial.println("Voo he thong nha ni");
            time_open = millis();

          } else {
            pass_wrong++;
            pass_in = "";
            lcd.setCursor(0, 1);
            lcd.print("Sai MK");
            //            Serial.println("Sai r ni oi");
            //            Serial.println(pass_wrong);
          }
        }
      }

      lcd.setCursor(0, 1);
      lcd.print(pass_in);
      break;
    case false:
      if (millis() % 100 == 0) {
        col++;
        lcd.clear();
      }

      lcd.setCursor(col, 0);
      lcd.print("WELCOME!!");

      if (stt_servo == true) {
        myservo.write(180);
        stt_servo = false;
        String s = "servo: ";
        s.concat(stt_servo);
        Serial.println(s);
        time_quay = millis();
      } else if (millis() - time_quay >= 2000) {
        myservo.write(90);
        time_quay = millis();
      }
      analogWrite(led_p1,dosang);
      analogWrite(led_p2,dosang2);
      if (digitalRead(btn_san_khach)) {

        if (stt_btn_san_khach == false) {
          stt_btn_san_khach = true;
          led_san_khach++;
          if (led_san_khach >= 4)
            led_san_khach = 0;

          switch (led_san_khach) {
            case 0:
              stt_led_san = 0;
              stt_led_khach = 0;
              break;
            case 1:

              stt_led_san = 0;
              stt_led_khach = 1;
              break;
            case 2:

              stt_led_san = 1;
              stt_led_khach = 0;
              break;
            case 3:

              stt_led_san = 1;
              stt_led_khach = 1;
              break;
          }
          String s = "led_san: ";
          s.concat(stt_led_san);
          Serial.println(s);
          s = "led_khach: ";
          s.concat(stt_led_khach);
          Serial.println(s);
        }
      } else {

        stt_btn_san_khach = false;
      }
      digitalWrite(led_san, stt_led_san);
      digitalWrite(led_khach, stt_led_khach);
      if (digitalRead(btn_hl_bep)) {
        if (stt_btn_hl == false) {
          led_hl_bep++;
          if (led_hl_bep > 3)
            led_hl_bep = 0;
          stt_btn_hl = true;
          switch (led_hl_bep) {
            case 0:
              stt_led_hl = 0;
              stt_led_bep = 0;
              break;
            case 1:
              stt_led_hl = 0;
              stt_led_bep = 1;
              break;
            case 2:
              stt_led_hl = 1;
              stt_led_bep = 0;
              break;
            case 3:
              stt_led_hl = 1;
              stt_led_bep = 1;
              break;
          }
          String s = "led_bep: ";
          s.concat(stt_led_bep);
          Serial.println(s);
          s = "led_hl: ";
          s.concat(stt_led_hl);
          Serial.println(s);
        }

      } else {
        stt_btn_hl = false;
      }
      digitalWrite(led_bep, stt_led_bep);
      digitalWrite(led_hl, stt_led_hl);
      if (digitalRead(btn_p1)) {

        if (stt_btn_p1 == false) {
          stt_btn_p1 = true;
          led_p1_hl++;
          if (led_p1_hl >= 3)
            led_p1_hl = 0;
          // Serial.println(led_p1_hl);
        }
      } else {

        stt_btn_p1 = false;
      }
      switch (led_p1_hl) {
        case 0:
          digitalWrite(led_p1, 0);
          break;
        case 1:
          analogWrite(led_p1, 255);
          break;
        case 2:
          analogWrite(led_p1, 50);
          ;
          break;
      }
      if (digitalRead(btn_p2)) {

        if (stt_btn_p2 == false) {
          stt_btn_p2 = true;
          led_p2_hl++;
          if (led_p2_hl >= 3)
            led_p2_hl = 0;
          // Serial.println(led_p2_hl);
        }
      } else {

        stt_btn_p2 = false;
      }
      switch (led_p2_hl) {
        case 0:
          digitalWrite(led_p2, 0);
          break;
        case 1:
          analogWrite(led_p2, 255);
          break;
        case 2:
          analogWrite(led_p2, 50);
          ;
          break;
      }
      if (digitalRead(btn_baodong)) {
        if (stt_btn_baodong == false) {
          baodong = !baodong;
          stt_btn_baodong = true;
          String s = "baodong: ";
          s.concat(baodong);
          Serial.println("baodong: ${baodong}");
        }

      } else {
        stt_btn_baodong = false;
      }
      if (baodong == true) {
        if (millis() % 10 == 0) {
          digitalWrite(led_san, !digitalRead(led_san));
          digitalWrite(led_hl, !digitalRead(led_hl));
          digitalWrite(led_khach, !digitalRead(led_khach));
          digitalWrite(led_p1, !digitalRead(led_p1));
          digitalWrite(led_p2, !digitalRead(led_p2));
          digitalWrite(led_bep, !digitalRead(led_bep));
        }
      }

      if (btn_cur_stt == 1) {
        if (t_high == 0)
        //Truoc do chua high gio bat dau high-->bat dau thao tac
        {
          t_high = t_cur;
        } else if (t_low != 0 && t_high2 == 0)
        //da high xong lan 1 (co t_low), high lan 2
        {
          t_high2 = t_cur;
        }
      } else {
        if (t_high != 0 && t_high2 == 0 && t_cur - t_high >= 3000)
        //da high lan 1 va chua high lan 2 nhung thoi gian thuc hien qua 3s
        {
          //          Serial.println("Nhan giu!");
          t_high = 0;
          t_low = 0;
          system_lock = true;
          pass_in = "";
          pass_wrong = 0;
          col = 0;


          digitalWrite(led_san, 0);
          digitalWrite(led_khach, 0);
          digitalWrite(led_hl, 0);
          digitalWrite(led_p1, 0);
          digitalWrite(led_p2, 0);
          digitalWrite(led_bep, 0);
          led_p1_hl = 0;
          led_san_khach = 0;
          led_p2_hl = 0;
          led_hl_bep = 0;

          lcd.clear();
        } else {
          if (t_high != 0 && t_cur - t_high > 1000)
          //da high lan 1 va thoi gian > 1000
          {
            if (t_high2 != 0 && t_cur - t_high2 >= 3000)
            //thoi gian high lan 2 >3s
            {
              //              Serial.println("Nhan giu!");
              t_high = 0;
              t_high2 = 0;
              t_low = 0;
              col = 0;
              system_lock = true;
              pass_in = "";
              pass_wrong = 0;
              digitalWrite(led_san, 0);
              digitalWrite(led_khach, 0);
              digitalWrite(led_hl, 0);
              digitalWrite(led_p1, 0);
              digitalWrite(led_p2, 0);
              digitalWrite(led_bep, 0);
              led_p1_hl = 0;
              led_san_khach = 0;

              led_p2_hl = 0;
              led_hl_bep = 0;
              lcd.clear();
            }
          } else {
            if (t_high != 0)
            //Neu da co high thi moi cap nhat t_low
            {
              t_low = t_cur;
            }
          }
        }
      }
      break;
  }
}
