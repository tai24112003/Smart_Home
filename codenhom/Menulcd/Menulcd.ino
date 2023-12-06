#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

char Menu1[] = "1San2Khach3P14P2";
char Menu2[] = "5HL 6Bep 7Nhatam";
String led = "Led:";

String receivedChar;
unsigned long t_high = 0;
unsigned long t_high2 = 0;
unsigned long t_low = 0;
unsigned long t2_high = 0;
unsigned long t2_high2 = 0;
unsigned long t2_low = 0;
int sttMenuselected = -1;
int countMenu = 0;
int countMenuSan = 0;

bool stt_led_san = LOW;
bool stt_led_khach = LOW;
bool stt_led_hl = LOW;      // Added for MenuHL
bool stt_led_bep = LOW;     // Added for MenuBep
short stt_led_p1 = 0;       // Added for P1
short stt_led_p2 = 0;       // Added for P2
bool stt_led_nhatam = LOW;  // Added for Nhatam
bool sttmenu = true;
bool stt_servo = LOW;
bool system_lock = true;
unsigned long times = millis();
void setup() {
  pinMode(4, INPUT);
  pinMode(3, INPUT);

  lcd.init();
  lcd.setCursor(0, 0);
  lcd.print(Menu1);
  lcd.setCursor(0, 1);
  lcd.print(Menu2);
  lcd.setCursor(0, 0);
  lcd.backlight();
  Serial.begin(9600);
}

void loop() {


  while (Serial.available() > 0) {
    receivedChar = Serial.readString();
    // Xử lý dữ liệu từ ESP8266 (ví dụ: in ra Serial Monitor)
    int vt = receivedChar.indexOf(":");
    String key = receivedChar.substring(0, vt);
    String value = receivedChar.substring(vt + 1);
    key.trim();
    value.trim();
<<<<<<< HEAD
    bool boolvalue = value.equalsIgnoreCase("1");

    if (key == "led_san")
=======
    bool boolvalue;
    boolvalue = value == "1";
    if (key.equals("led_san"))
>>>>>>> origin/quan
      stt_led_san = boolvalue;
    else if (key.equals("led_khach"))
      stt_led_khach = boolvalue;
<<<<<<< HEAD
    else if (key == "led_hl")  // Added for MenuHL
      stt_led_hl = boolvalue;
    else if (key == "led_bep")  // Added for MenuBep
      stt_led_bep = boolvalue;
    else if (key == "led_p1")  // Added for P1
      stt_led_p1 = boolvalue;
    else if (key == "led_p2")  // Added for P2
      stt_led_p2 = boolvalue;
    else if (key == "led_nhatam")  // Added for Nhatam
      stt_led_nhatam = boolvalue;
  }

  unsigned long t_cur = millis();
  int btn_cur_stt = digitalRead(4);

  if (btn_cur_stt == 0) {
    if (t_high == 0) {
      t_high = t_cur;
    } else if (t_low != 0 && t_high2 == 0) {
      t_high2 = t_cur;
    }
  } else {
    if (t_high != 0 && t_high2 == 0 && t_cur - t_high >= 3000) {
      if (sttMenuselected == 0 && sttmenu == false) {
        Serial.println("led_san: " + String(stt_led_san ? "0" : "1"));
      } else if (sttMenuselected == 1 && sttmenu == false) {
        Serial.println("led_khach: " + String(stt_led_khach ? "0" : "1"));
      } else if (sttMenuselected == 2 && sttmenu == false) {
        Serial.println("led_ngu1: " + String(stt_led_p1 ? "0" : "1"));  // Added for P1
      } else if (sttMenuselected == 3 && sttmenu == false) {
        Serial.println("led_ngu2: " + String(stt_led_p2 ? "0" : "1"));  // Added for P2
      } else if (sttMenuselected == 4 && sttmenu == false) {
        Serial.println("led_hl: " + String(stt_led_hl ? "0" : "1"));  // Added for Nhatam
      } else if (sttMenuselected == 5 && sttmenu == false) {
        Serial.println("led_bep: " + String(stt_led_bep ? "0" : "1"));  // Added for MenuHL
      } else if (sttMenuselected == 6 && sttmenu == false) {
        Serial.println("led_nhatam: " + String(stt_led_nhatam ? "0" : "1"));  // Added for MenuBep
      }

      if (countMenu == 0) {
        sttmenu = false;
        sttMenuselected = countMenu;
=======
    else if (key.equals("led_hl"))
      stt_led_hl = boolvalue;
    else if (key.equals("led_bep"))
      stt_led_bep = boolvalue;
    else if (key.equals("servo"))
      stt_servo = boolvalue;
    else if (key.equals("led_ngu1"))
      stt_led_p1 = value.toInt();
    else if (key.equals("led_ngu2"))
      stt_led_p2 = value.toInt();
    else if (key.equals("system_lock"))
      system_lock = boolvalue;
  }
  if (system_lock == false) {
    unsigned long t_cur = millis();
    int btn_cur_stt = digitalRead(4);
    if (btn_cur_stt == 0) {
      if (t_high == 0) {
        t_high = t_cur;
      } else if (t_low != 0 && t_high2 == 0) {
        t_high2 = t_cur;
>>>>>>> origin/quan
      }
    } else {
<<<<<<< HEAD
      if (t_high != 0 && t_cur - t_high > 500) {
        if (t_high2 != 0 && t_cur - t_high2 >= 3000) {
          if (sttMenuselected == 0 && sttmenu == false) {
            Serial.println("led_san: " + String(stt_led_hl ? "0" : "1"));
          } else if (sttMenuselected == 1 && sttmenu == false) {
            Serial.println("led_khach: " + String(stt_led_hl ? "0" : "1"));
          } else if (sttMenuselected == 2 && sttmenu == false) {
            Serial.println("led_ngu1: " + String(stt_led_hl ? "0" : "1"));  // Added for P1
          } else if (sttMenuselected == 3 && sttmenu == false) {
            Serial.println("led_ngu2: " + String(stt_led_hl ? "0" : "1"));  // Added for P2
          } else if (sttMenuselected == 4 && sttmenu == false) {
            Serial.println("led_hl: " + String(stt_led_hl ? "0" : "1"));  // Added for Nhatam
          } else if (sttMenuselected == 5 && sttmenu == false) {
            Serial.println("led_bep: " + String(stt_led_hl ? "0" : "1"));  // Added for MenuHL
          } else if (sttMenuselected == 6 && sttmenu == false) {
            Serial.println("led_nhatam: " + String(stt_led_hl ? "0" : "1"));  // Added for MenuBep
          }
=======
      if (t_high != 0 && t_high2 == 0 && t_cur - t_high >= 3000) {
        if (sttMenuselected == 0 && sttmenu == false) {
          if (countMenuSan == 0) Serial.println("led_san: " + String(stt_led_san ? "0" : "1"));
          if (countMenuSan == 2) {
            Serial.println("servo: " + String(stt_servo ? "0" : "1"));
          } else if (sttMenuselected == 1 && sttmenu == false) {
            Serial.println("led_khach: " + String(stt_led_khach ? "0" : "1"));
          } else if (sttMenuselected == 2 && sttmenu == false) {

            Serial.println("led_ngu1: " + String(stt_led_p1 < 250 ? stt_led_p1 + 50 : 0));
          } else if (sttMenuselected == 3 && sttmenu == false) {
            Serial.println("led_ngu2: " + String(stt_led_p2 < 250 ? stt_led_p2 + 50 : 0));
          } else if (sttMenuselected == 4 && sttmenu == false) {
            Serial.println("led_hl: " + String(stt_led_hl ? "0" : "1"));  // Added for Nhatam
          } else if (sttMenuselected == 5 && sttmenu == false) {
            Serial.println("led_bep: " + String(stt_led_bep ? "0" : "1"));  // Added for MenuHL
          } else if (sttMenuselected == 6 && sttmenu == false) {
            Serial.println("led_nhatam: " + String(stt_led_nhatam ? "0" : "1"));  // Added for MenuBep
          }

>>>>>>> origin/quan
          if (countMenu == 0) {

            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 1) {
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 2) {  // Added for P1
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 3) {  // Added for P2
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 4) {  // Added for Nhatam
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 5) {  // Added for MenuHL
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          if (countMenu == 6) {  // Added for MenuBep
            sttmenu = false;
            sttMenuselected = countMenu;
          }
          t_high = 0;
          t_low = 0;
        } else if (t_high2 != 0 && t_cur - t_high <= 500) {
          if (sttmenu == false) {
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print(Menu1);
            lcd.setCursor(0, 1);
            lcd.print(Menu2);
            lcd.setCursor(0, 0);
            sttmenu = true;
          }
          t_high = 0;
          t_high2 = 0;
          t_low = 0;
        } else {
          if (t_high != 0 && t_cur - t_high > 500) {
            if (t_high2 != 0 && t_cur - t_high2 >= 3000) {
              if (sttMenuselected == 0 && sttmenu == false) {
                if (countMenuSan == 0) Serial.println("led_san: " + String(stt_led_san ? "0" : "1"));
                if (countMenuSan == 2) {
                  Serial.println("servo: " + String(stt_servo ? "0" : "1"));
                }

              } else if (sttMenuselected == 1 && sttmenu == false) {
                Serial.println("led_khach: " + String(stt_led_khach ? "0" : "1"));
              } else if (sttMenuselected == 2 && sttmenu == false) {

                Serial.println("led_ngu1: " + String(stt_led_p1 < 250 ? stt_led_p1 + 50 : 0));
              } else if (sttMenuselected == 3 && sttmenu == false) {
                Serial.println("led_ngu2: " + String(stt_led_p2 < 250 ? stt_led_p2 + 50 : 0));
              } else if (sttMenuselected == 4 && sttmenu == false) {
                Serial.println("led_hl: " + String(stt_led_hl ? "0" : "1"));  // Added for Nhatam
              } else if (sttMenuselected == 5 && sttmenu == false) {
                Serial.println("led_bep: " + String(stt_led_bep ? "0" : "1"));  // Added for MenuHL
              } else if (sttMenuselected == 6 && sttmenu == false) {
                Serial.println("led_nhatam: " + String(stt_led_nhatam ? "0" : "1"));  // Added for MenuBep
              }

              if (countMenu == 0) {
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 1) {
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 2) {  // Added for P1
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 3) {  // Added for P2
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 4) {  // Added for Nhatam
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 5) {  // Added for MenuHL
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              if (countMenu == 6) {  // Added for MenuBep
                sttmenu = false;
                sttMenuselected = countMenu;
              }
              t_high = 0;
              t_high2 = 0;
              t_low = 0;
            } else {
              if (sttmenu == true)
                countMenu++;
              t_high = 0;
              t_high2 = 0;
              t_low = 0;
            }
          } else {
            if (t_high != 0) {
              t_low = t_cur;
            }
          }
        }
      }

      lcd.blink();
      if (sttmenu == true && countMenu == 0) {
        lcd.setCursor(0, 0);
      } else if (sttmenu == true && countMenu == 1) {
        lcd.setCursor(4, 0);
      } else if (sttmenu == true && countMenu == 2) {
        lcd.setCursor(10, 0);
      } else if (sttmenu == true && countMenu == 3) {
        lcd.setCursor(13, 0);
      } else if (sttmenu == true && countMenu == 4) {
        lcd.setCursor(0, 1);
      } else if (sttmenu == true && countMenu == 5) {
        lcd.setCursor(4, 1);
      } else if (sttmenu == true && countMenu == 6) {
        lcd.setCursor(9, 1);
      } else if (sttmenu == true && countMenu == 7) {
        countMenu = 0;
      }
      unsigned long t2_cur = millis();
      int btn_cur_stt2 = digitalRead(3);
      if (btn_cur_stt2 == 0) {
        if (t2_high == 0)
        //Truoc do chua high gio bat dau high-->bat dau thao tac
        {
          t2_high = t2_cur;
        } else if (t2_low != 0 && t2_high2 == 0)
        //da high xong lan 1 (co t_low), high lan 2
        {
          t2_high2 = t2_cur;
        }
      } else {
        if (t2_high != 0 && t2_high2 == 0 && t2_cur - t2_high >= 3000)
        //da high lan 1 va chua high lan 2 nhung thoi gian thuc hien qua 3s
        {
          Serial.println("Nhan giu!");
          t2_high = 0;
          t2_low = 0;

        } else if (t2_high2 != 0 && t2_cur - t2_high <= 1000)
        //da high lan 2 va thoi gian <= 1s
        {
          Serial.println("Nhan double!");
          t2_high = 0;
          t2_high2 = 0;
          t2_low = 0;
        } else {
          if (t2_high != 0 && t2_cur - t2_high > 1000)
          //da high lan 1 va thoi gian > 1000
          {
            if (t2_high2 != 0 && t2_cur - t2_high2 >= 3000)
            //thoi gian high lan 2 >3s
            {
              Serial.println("Nhan giu!");
              t2_high = 0;
              t2_high2 = 0;
              t2_low = 0;
            } else {
              if (sttmenu == false && sttMenuselected == 0) {
                countMenuSan++;
              }
              t2_high = 0;
              t2_high2 = 0;
              t2_low = 0;
            }
          } else {
            if (t2_high != 0)
            //Neu da co high thi moi cap nhat t_low
            {
              t2_low = t2_cur;
            }
          }
        }
      }


      if (sttMenuselected == 0 && sttmenu == false) {

        if (millis() - times > 1000) {

          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_san ? "ON" : "OFF") + String(" rss:") + String(analogRead(A0)));
          lcd.setCursor(0, 1);
          lcd.print("Servo:" + String(stt_servo) + String(" LCD"));
          if (countMenuSan == 0) {
            lcd.setCursor(4, 0);
          } else if (countMenuSan == 1) {
            lcd.setCursor(11, 0);
          } else if (countMenuSan == 2) {
            lcd.setCursor(7, 1);
          } else if (countMenuSan == 3) {
            lcd.setCursor(11, 1);
          } else if (countMenuSan == 4) {
            countMenuSan = 0;
          }
          times = millis();
        }

      } else if (sttMenuselected == 1 && sttmenu == false) {
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_khach ? "ON" : "OFF"));
          lcd.setCursor(4, 0);
          times = millis();
        }

      } else if (sttMenuselected == 2 && sttmenu == false) {  // Added for P1
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_p1));
          lcd.setCursor(4, 0);
          times = millis();
        }
      } else if (sttMenuselected == 3 && sttmenu == false) {  // Added for P2
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_p2));
        }
        lcd.setCursor(4, 0);
      } else if (sttMenuselected == 4 && sttmenu == false) {  // Added for Nhatam
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_hl ? "ON" : "OFF"));
          lcd.setCursor(4, 0);
          times = millis();
        }
      } else if (sttMenuselected == 5 && sttmenu == false) {  // Added for MenuHL
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_bep ? "ON" : "OFF"));
          lcd.setCursor(0, 1);
          lcd.print("Sensor Smoke:" + String(""));
          lcd.setCursor(4, 0);

          times = millis();
        }

      } else if (sttMenuselected == 6 && sttmenu == false) {  // Added for MenuBep
        if (millis() - times > 1000) {
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Led:" + String(stt_led_nhatam ? "ON" : "OFF"));
          lcd.setCursor(4, 0);
          times = millis();
        }
      }
    }
  }
<<<<<<< HEAD

  lcd.blink();
  if (sttmenu == true && countMenu == 0) {
    lcd.setCursor(0, 0);
  } else if (sttmenu == true && countMenu == 1) {
    lcd.setCursor(4, 0);
  } else if (sttmenu == true && countMenu == 2) {
    lcd.setCursor(10, 0);
  } else if (sttmenu == true && countMenu == 3) {
    lcd.setCursor(13, 0);
  } else if (sttmenu == true && countMenu == 4) {
    lcd.setCursor(0, 1);
  } else if (sttmenu == true && countMenu == 5) {
    lcd.setCursor(4, 1);
  } else if (sttmenu == true && countMenu == 6) {
    lcd.setCursor(9, 1);
  } else if (sttmenu == true && countMenu == 7) {
    countMenu = 0;
  }

  if (sttMenuselected == 0 && sttmenu == false) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_san ? "ON" : "OFF"));
  } else if (sttMenuselected == 1 && sttmenu == false) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_khach ? "ON" : "OFF"));
  } else if (sttMenuselected == 2 && sttmenu == false) {  // Added for P1
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_p1 ? "ON" : "OFF"));
  } else if (sttMenuselected == 3 && sttmenu == false) {  // Added for P2
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_p2 ? "ON" : "OFF"));
  } else if (sttMenuselected == 4 && sttmenu == false) {  // Added for Nhatam
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_hl ? "ON" : "OFF"));
  } else if (sttMenuselected == 5 && sttmenu == false) {  // Added for MenuHL
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_bep ? "ON" : "OFF"));
  } else if (sttMenuselected == 6 && sttmenu == false) {  // Added for MenuBep
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:" + String(stt_led_nhatam ? "ON" : "OFF"));
  }
=======
>>>>>>> origin/quan
}
