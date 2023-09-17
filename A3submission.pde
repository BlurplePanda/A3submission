Player player;
enum Movements {
    LEFT,
    RIGHT,
    LEFT_IDLE,
    RIGHT_IDLE
}
boolean aPressed = false;
boolean dPressed = false;

void setup() {
  size(500,500);
  frameRate(60);
  player = new Player(50, 100);
}

void draw() {
  background(255);
  if (!aPressed && !dPressed) {
    player.stop();
  }
  else if (aPressed) {
    player.moveLeft();
  }
  else if (dPressed) {
    player.moveRight();
  }
  player.display();
}

void keyPressed() {
  if (key == 'a') {
      aPressed = true;
  }
  else if (key == 'd') {
      dPressed = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    aPressed = false;
  }
  else if (key == 'd') {
    dPressed = false;
  }
}
