void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      p2Up = true;
    }
    if (keyCode == LEFT) {
      p2Down = true;
    }
  } else {
    if (key == 'w') {
      p1Up = true;
    }
    if (key == 's') {
      p1Down = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      p2Up = false;
    }
    if (keyCode == LEFT) {
      p2Down = false;
    }
  } else {
    if (key == 'w') {
      p1Up = false;
    }
    if (key == 's') {
      p1Down = false;
    }
  }
}

void mousePressed() {
  onePlayer = !onePlayer;
  p1Score = 0;
  p2Score = 0;
}
