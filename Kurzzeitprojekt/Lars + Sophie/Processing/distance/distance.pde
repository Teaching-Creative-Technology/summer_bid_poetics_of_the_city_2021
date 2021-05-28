// PROCESSING DISTANCE

import processing.serial.*;
Serial myPort;
float data; // ich habe hier den wert von String nach float geändert
PFont  myFont;
float x;
float easing = 0.05;
int lf = 10;      // ASCII linefeed. \n entspricht in ASCII dem Zeichen 10
int textSize = 20;
boolean debug = false;
float paddleW, paddleH;

void setup() {
  //size(1366, 900); // size of processing window
  size(400, 400); // hab das für debugging zwecke mal kleiner gemacht
  background(0);// setting background color to black

  // port finden
  if(debug) for(int i = 0; i<Serial.list().length; i++)println(Serial.list()[i]);
  
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil(lf);
  
  // einmalige geschichten texAlign, textSize können auch im setup() ausgeführt werden
  textAlign(CENTER, CENTER);
  textSize(textSize);
  
  paddleW = 80;
  paddleH = 20;
}

void draw() {
  background(0);
  fill(255);
  fill(#4B5DCE);
  
  text("Distance: " + data +" cm", width/2, height-30);
  noFill();
  stroke(#4B5DCE);

  if(!Float.isNaN(data)) { 
    float mapped = map(data, 0, 1000, 0, width);
    float dx = mapped - x;
    x += dx * easing;
    
    float constrained = constrain(x, 0, width-paddleW);
    rect(constrained, 100, paddleW, paddleH);
  }
}

void serialEvent(Serial myPort) {
  // unsere seriellen daten werden von string nach float umgewandelt
  data = float( myPort.readStringUntil(lf).trim() ); // hier habe ich trim() angefügt
  // trim() entfernt leerzeichen / whitespaces
  // aber auch das LF-Symbol was das Arduino euch mitsendet
  // https://processing.org/reference/trim_.html
  
}
