class Player {
    // animations
    Animation idleRight = new Animation("character/Idle", true);
    Animation idleLeft = new Animation("character/Idle_l", true);
    Animation runRight = new Animation("character/Run", true);
    Animation runLeft = new Animation("character/Run_l", true);
    Animation jumpRight = new Animation("character/Jump", false);
    Animation jumpLeft = new Animation("character/Jump_l", false);
    
    Animation currentAnimation = idleRight;
    Movements movement = Movements.RIGHT_IDLE;
    float x;
    float vX = 5;
    float y;
    float vY = 0;
    float gravity = 0.1;

    Player(float x, float y) {
        this.x = x;
        this.y = y;
    }

    Movements getMovement() {
        return movement;
    }

    void goLeft() {
        movement = Movements.LEFT;
        currentAnimation = runLeft;
        moveLeft();
    }
    void moveLeft() {
        if (x <= 0.2*width) {
            cameraX += vX;
        }
        else {
            x -= vX;
        }
    }

    void goRight() {
        movement = Movements.RIGHT;
        currentAnimation = runRight;
        moveRight();
    }
    void moveRight() {
        if (x+runRight.getWidth() >= 0.8*width) {
            cameraX -= vX;
        }
        else {
            x += vX;
        }
    }

    void stop() {
        if (movement == Movements.RIGHT) {
            movement = Movements.RIGHT_IDLE;
            currentAnimation = idleRight;
        }
        else if (movement == Movements.LEFT) {
            movement = Movements.LEFT_IDLE;
            currentAnimation = idleLeft;
        }
    }

    void startJump() {
        if (movement == Movements.RIGHT || movement == Movements.RIGHT_IDLE) {
            movement = Movements.JUMP_RIGHT;
            currentAnimation = jumpRight;
        }
        else if (movement == Movements.LEFT || movement == Movements.LEFT_IDLE) {
            movement = Movements.JUMP_LEFT;
            currentAnimation = jumpLeft;
        }
        vY = 3;
    }

    void continueJump() {
        if (movement == Movements.JUMP_RIGHT) {
            moveRight();
        }
        else if (movement == Movements.JUMP_LEFT) {
            moveLeft();
        }
        if(abs(vY) > abs(200 - y) && vY < 0) {
            //if the movement will take it below ground, just set y to ground
            y = 200;
        }
        else { // otherwise move it normally
            y -= vY;
            vY -= gravity;
        }
    }

    void endJump() {
        if (movement == Movements.JUMP_RIGHT) {
            movement = Movements.RIGHT_IDLE;
            currentAnimation = idleRight;
        }
        else if (movement == Movements.JUMP_LEFT) {
            movement = Movements.LEFT_IDLE;
            currentAnimation = idleLeft;
        }
    }

    float getX() {
        return x;
    }
    float getY() {
        return y;
    }
    float getVX() {
        return vX;
    }

    void display() {
        currentAnimation.display(x, y);
        currentAnimation.updateSprite();
    }
}