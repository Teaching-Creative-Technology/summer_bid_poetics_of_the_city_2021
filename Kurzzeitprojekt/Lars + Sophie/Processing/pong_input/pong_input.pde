// PROCESSING PONG

float p1, p2;
int p1Score, p2Score;
float ballX, ballY, dBX, dBY;
float ballD, paddleW, paddleH, paddleG;
boolean p1Up, p1Down, p2Up, p2Down;
boolean onePlayer = true; // direkt CPU an

// kopiert aus dem distance sketch
import processing.serial.*;
Serial myPort;
float data; // ich habe hier den wert von String nach float geändert
float x;
float easing = 0.05;
int lf = 10;      // ASCII linefeed. \n entspricht in ASCII dem Zeichen 10

void setup() {
  size(600, 600); // ich habe das hier mal auf ein rechteck gesetzt. lässt sich leichter rotieren, s. unten
  
  frameRate(60);
  rectMode(CENTER);
  textSize(50);
  textAlign(CENTER);
  fill(255);

  p1 = height/2;
  p2 = height/2;
  ballX = width/2;
  ballY = height/2;
  dBX = random(2, 6);
  dBY = random(2, 6);
  ballD = 25;
  paddleW = 20;
  paddleH = 80;
  paddleG = 30;
  
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil(lf);
}

void draw() {
  //Changes positions of paddles based on which keys are pressed
  
  getInput(); // input vom arduino empfangen
  
  if (p1Up) {
    p1 -= 5;
  }
  if (p1Down) {
    p1 += 5;
  }

  //Computer
  if (onePlayer) {
    p1 = ballY;
  }

  //Keeps paddles on the screen
  p1 = constrain(p1, paddleH/2, height - paddleH/2);
  p2 = constrain(p2, paddleH/2, height - paddleH/2);

  //Keeps ball on the screen (and adds to scores)
  if (ballX - ballD/2 < 0) {
    p2Score += 1;
    ballX = width/2;
    ballY = height/2;
    dBX = random(2, 6);
    dBY = random(2, 6);
  }
  if (ballX + ballD/2 > width) {
    p1Score += 1;
    ballX = width/2;
    ballY = height/2;
    dBX = random(2, 6);
    dBY = random(2, 6);
  }

  if (ballY - ballD/2 < 0 || ballY + ballD/2 > height) {
    dBY = -dBY;
  }

  //Draws paddles and ball
  // mit translate wird die zeichenfläche auf dem bildschirm verschoben
  // und mit rotate kippt man das ganze um 90°, sodass es wie gewünscht auf dem bildschirm erscheint
  translate(600, 0);
  rotate(radians(90));
  background(0);
  rect(paddleG, p1, paddleW, paddleH);
  rect(width-paddleG, p2, paddleW, paddleH);
  ellipse(ballX, ballY, ballD, ballD);

  //Updates ball's position
  ballX += dBX;
  ballY += dBY;

  //Checks if ball hit paddles
  if ((ballX - ballD/2 <= paddleG + paddleW/2) && (ballY + ballD/2 >= p1 - paddleH/2) && (ballY - ballD/2 <= p1 + paddleH/2)) {
    dBX = -dBX;
  }
  if ((ballX + ballD/2 >= width - paddleG - paddleW/2) && (ballY + ballD/2 >= p2 - paddleH/2) && (ballY - ballD/2 <= p2 + paddleH/2)) {
    dBX = -dBX;
  }
}

void serialEvent(Serial myPort) {
  // unsere seriellen daten werden von string nach float umgewandelt
  data = float( myPort.readStringUntil(lf).trim() ); // hier habe ich trim() angefügt
  // trim() entfernt leerzeichen / whitespaces
  // aber auch das LF-Symbol was das Arduino euch mitsendet
  // https://processing.org/reference/trim_.html
  
}

void getInput() {
  if(!Float.isNaN(data)) { 
    float mapped = map(data, 0, 1000, 0, width);
    float dx = mapped - x;
    x += dx * easing;
   
    float constrained = constrain(x, 0, width-paddleW);
    p2 = constrained;
  }
}
