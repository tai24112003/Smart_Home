#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

char Menu1[] = "1San2Khach3P14P2";
char Menu2[] = "5HL 6Bep 7Nhatam";
String led = "Led:";

String receivedChar;
unsigned long t_high = 0;
unsigned long t_high2 = 0;
unsigned long t_low = 0;
int sttMenuselected = -1;
int countMenu = 0;
bool stt_led_san = LOW;
bool stt_led_khach = LOW;
bool stt_led_hl = LOW;  // Added for MenuHL
bool stt_led_bep = LOW; // Added for MenuBep
bool stt_led_p1 = LOW;  // Added for P1
bool stt_led_p2 = LOW;  // Added for P2
bool stt_led_nhatam = LOW;  // Added for Nhatam
bool sttmenu = true;

void setup() {
  pinMode(4, INPUT);
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
    int vt = receivedChar.indexOf(":");
    String key = receivedChar.substring(0, vt);
    String value = receivedChar.substring(vt + 1);
    key.trim();
    value.trim();
    bool boolvalue = value.equalsIgnoreCase("1");
    
    if (key == "led_san")
      stt_led_san = boolvalue;
    else if (key == "led_khach")
      stt_led_khach = boolvalue;
    else if (key == "led_hl") // Added for MenuHL
      stt_led_hl = boolvalue;
    else if (key == "led_bep") // Added for MenuBep
      stt_led_bep = boolvalue;
    else if (key == "led_p1") // Added for P1
      stt_led_p1 = boolvalue;
    else if (key == "led_p2") // Added for P2
      stt_led_p2 = boolvalue;
    else if (key == "led_nhatam") // Added for Nhatam
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
            Serial.println("led_san: "+String(stt_led_san? "0":"1"));
  } else if (sttMenuselected == 1 && sttmenu == false) {
    Serial.println("led_khach: "+String(stt_led_khach? "0":"1"));
  } else if (sttMenuselected == 2 && sttmenu == false) { 
    Serial.println("led_ngu1: "+String(stt_led_p1? "0":"1")); // Added for P1
  } else if (sttMenuselected == 3 && sttmenu == false) { 
    Serial.println("led_ngu2: "+String(stt_led_p2? "0":"1")); // Added for P2
  } else if (sttMenuselected == 4 && sttmenu == false) { 
    Serial.println("led_hl: "+String(stt_led_hl? "0":"1")); // Added for Nhatam
  } else if (sttMenuselected == 5 && sttmenu == false) { 
    Serial.println("led_bep: "+String(stt_led_bep? "0":"1")); // Added for MenuHL
  } else if (sttMenuselected == 6 && sttmenu == false) { 
    Serial.println("led_nhatam: "+String(stt_led_nhatam? "0":"1")); // Added for MenuBep
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
            Serial.println("led_san: "+String(stt_led_hl? "0":"1"));
  } else if (sttMenuselected == 1 && sttmenu == false) {
    Serial.println("led_khach: "+String(stt_led_hl? "0":"1"));
  } else if (sttMenuselected == 2 && sttmenu == false) { 
    Serial.println("led_ngu1: "+String(stt_led_hl? "0":"1")); // Added for P1
  } else if (sttMenuselected == 3 && sttmenu == false) { 
    Serial.println("led_ngu2: "+String(stt_led_hl? "0":"1")); // Added for P2
  } else if (sttMenuselected == 4 && sttmenu == false) { 
    Serial.println("led_hl: "+String(stt_led_hl? "0":"1")); // Added for Nhatam
  } else if (sttMenuselected == 5 && sttmenu == false) { 
    Serial.println("led_bep: "+String(stt_led_hl? "0":"1")); // Added for MenuHL
  } else if (sttMenuselected == 6 && sttmenu == false) { 
    Serial.println("led_nhatam: "+String(stt_led_hl? "0":"1")); // Added for MenuBep
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

  if (sttMenuselected == 0 && sttmenu == false) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_san? "ON":"OFF"));
  } else if (sttMenuselected == 1 && sttmenu == false) {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_khach? "ON":"OFF"));
  } else if (sttMenuselected == 2 && sttmenu == false) {  // Added for P1
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_p1? "ON":"OFF"));
  } else if (sttMenuselected == 3 && sttmenu == false) {  // Added for P2
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_p2? "ON":"OFF"));
  } else if (sttMenuselected == 4 && sttmenu == false) {  // Added for Nhatam
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_hl? "ON":"OFF"));
  } else if (sttMenuselected == 5 && sttmenu == false) {  // Added for MenuHL
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_bep? "ON":"OFF"));
  } else if (sttMenuselected == 6 && sttmenu == false) {  // Added for MenuBep
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Led:"+String(stt_led_nhatam? "ON":"OFF"));
  }
}
