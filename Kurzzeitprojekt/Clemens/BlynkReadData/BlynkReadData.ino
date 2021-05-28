#define BLYNK_PRINT Serial

#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

char auth[] = "auth_tiken";

char ssid[] = "ssid";
char pass[] = "pw";

float value = 0;

BLYNK_WRITE(V1) { // V1 = Virtueller Pin 1
  int pinValue = param.asInt(); // assigning incoming value from pin V1 to a variable
  // You can also use:
  // String i = param.asStr();
  // double d = param.asDouble();
  Serial.print("V1 Slider value is: ");
  Serial.println(pinValue);
  value = pinValue;
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
