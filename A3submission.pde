Player player;
enum Movements {
    LEFT,
    RIGHT,
    LEFT_IDLE,
    RIGHT_IDLE
}
boolean aPressed = false;
boolean dPressed = false;
Background front_bg, mid_bg, back_bg;
float cameraX = 0;

void setup() {
  size(640, 360);
  frameRate(60);
  player = new Player(0, 200);
  front_bg = new Background("background/bg_layer_1.png", 1);
  mid_bg = new Background("background/bg_layer_2.png", 2);
  back_bg = new Background("background/bg_layer_3.png", 3);
}

void draw() {
  back_bg.display();
  mid_bg.display();
  front_bg.display();
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
