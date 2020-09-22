#include <Sim800l.h>
#include <SoftwareSerial.h>

Sim800l Sim800l;
String message;
String number;

int pins[] = {7, 6, 5, 4};
bool states[] = {LOW, LOW, LOW, LOW};

void setup() {
  Serial.begin(9600);
  Serial.println("Serial OK...");

  Sim800l.begin();
  Sim800l.delAllSms();
  
  Serial.println("Sim800l OK...");

  for(int i=0; i<(sizeof(states)/sizeof(bool)); i++) {
    states[i] = LOW;
  }
  
  for(int i=0; i<(sizeof(pins)/sizeof(int)); i++) {
    pinMode(pins[i], OUTPUT);
    digitalWrite(pins[i], HIGH);
  }
}

void setRelayState(pos, state) {
  digitalWrite(pos, state);
  states[pos] = state;
}

void sms() {
  Serial.print(".");
  message = Sim800l.readSms(1); //  message = Serial.readString();
  
  if(message.length() > 0) {
    message.toUpperCase();

    Serial.println("Mensagem: "+message);

    if(message.indexOf("PPPINFO") != -1) {
      number = getNumberSms(1);

      String result = "";
      for(int i=0; i<(sizeof(states)/sizeof(bool)); i++) {
        result += i+1;
        result += ": ";
        if(states[i]) {
          result += "LIGADO";
        } else {
          result += "DESLIGADO";
        }
        result += " | "
      }

      Sim800l.sendSms(number, result);
    }

    if(message.indexOf("PPPDTODOS") != -1) {
      for(int i=4; i<=7; i++) {
        digitalWrite(i, HIGH);
      }
    }

    for(int i=1; i<=4; i++) {
      String n = String(i);
      String on = "PPPL"+n;
      String off = "PPPD"+n;
      String timer = "PPPT"+n;

      int p = i-1; 
      if(message.indexOf(on) != -1) {
        setRelayState(p, LOW);
      }

      if(message.indexOf(off) != -1) {
        setRelayState(p, HIGH);
      }

      if(message.indexOf(timer) != -1) {
        setRelayState(p, LOW);
        delay(10000);
        setRelayState(p, HIGH);
      }
    }

    Sim800l.delAllSms();
  }
  
}

void loop() {
  sms(); 
  delay(1000);
}
