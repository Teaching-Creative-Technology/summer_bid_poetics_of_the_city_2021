#define BLYNK_PRINT Serial

#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

char auth[] = "auth_token";

char ssid[] = "id";
char pass[] = "pw";

float value = 0;

BLYNK_WRITE(V1) { // V1 = Virtueller Pin 1
  value = param.asInt();
}

void setup() {
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pass);
}

void loop() {
  Blynk.run();
  if(value < 500) {
    Serial.println("Wert unter 500");
  } else {
    Serial.println("Wert über 500");
  }
}
