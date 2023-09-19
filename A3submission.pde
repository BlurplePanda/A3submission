Player player; //the player character!
enum Movements { //states of movement
    LEFT,
    RIGHT,
    LEFT_IDLE,
    RIGHT_IDLE,
    JUMP_LEFT,
    JUMP_RIGHT
}
boolean aPressed = false; //if key is pressed
boolean dPressed = false;
boolean jumping = false; //if player is jumping
Background front_bg, mid_bg, back_bg; //background layers
float cameraX = 0; //"camera" offset position

/**
* Processing setup function - sets size/framerate initialises variables/instances
*/
void setup() {
    size(640, 360, P2D);
    frameRate(60);
    player = new Player(0, 200); //create player at left bottom of screen
    front_bg = new Background("background/bg_layer_1.png", 1);
    mid_bg = new Background("background/bg_layer_2.png", 2);
    back_bg = new Background("background/bg_layer_3.png", 3);
}

/**
* Processing draw function - runs every time the frame changes (depends on frameRate())
* Ensures everything in the game is displayed at the right time/in the right states etc
*/
void draw() {
    //display background(s)
    back_bg.display();
    mid_bg.display();
    front_bg.display();
    
    //character movement
    if (aPressed) {
        player.moveLeft();  
    }
    if (dPressed) {
        player.moveRight();
    }
    if (!aPressed && !dPressed) {
        player.stop();
    }
    
    //display character
    player.display();
}

/**
* Processing function - run whenever a key is pressed
* This one mostly just sets booleans to keep track of what the keyboard is doing
*/
void keyPressed() {
    //allows for smoother movement mechanics than calling move function directly here
    if (key == 'a') {
        aPressed = true;
    }
    if (key == 'd') {
        dPressed = true;
    }
    
    if (key == ' ') {
        if (!jumping) {
            jumping = true;
            player.startJump(); //make the player start jumping!
        }
    }
}

/**
* Processing function - run whenever a key is released
* This one just sets booleans to keep track of keyboard
*/
void keyReleased() {
    if (key == 'a') {
        aPressed = false;
    }
    if (key == 'd') {
        dPressed = false;
    }
}
