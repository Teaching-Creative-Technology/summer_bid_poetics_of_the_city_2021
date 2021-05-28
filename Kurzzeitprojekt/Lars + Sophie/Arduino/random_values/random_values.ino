// Dieser Sketch erzeugt random* cm Werte auf dem Arduino da ich
// gerade keinen Ultraschallsensor hier rumliegen habe

int distance;

void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
}

void loop() {
  distance = analogRead(A0);
  // analoges signal von 0 bis 1023 bits mappen auf 0cm bis 1000cm
  int m = map(distance, 0, 1023, 0, 1000);
  Serial.println(m);
}
