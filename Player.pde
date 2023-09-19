class Player {
    // animations
    Animation idle = new Animation("character/Idle", true);
    Animation run = new Animation("character/Run", true);
    Animation jumpStart = new Animation("character/Jump-Start", false);
    Animation jumpMid = new Animation("character/Jump-Mid", false);
    Animation jumpEnd = new Animation("character/Jump-End", false);
    
    boolean facingLeft = false;
    
    Animation currentAnimation = idle;
    Movements movement = Movements.RIGHT_IDLE;
    float x;
    float vX = 5;
    float y;
    float vY = 0;
    float jumpVel = 3;
    float gravity = 0.1;
    float ground = 200;

    Player(float x, float y) {
        this.x = x;
        this.y = y;
    }

    Movements getMovement() {
        return movement;
    }

    void moveLeft() {
        facingLeft = true;
        if (jumping) {
            movement = Movements.JUMP_LEFT;
            continueJump();
        }
        else {
            movement = Movements.LEFT;
            currentAnimation = run;
        }
        if (x <= 0.2*width) {
            cameraX += vX;
        }
        else {
            x -= vX;
        }
    }

    void moveRight() {
        facingLeft = false;
        if (jumping) {
            movement = Movements.JUMP_RIGHT;
            continueJump();
        }
        else {
            movement = Movements.RIGHT;
            currentAnimation = run;
        }
        if (x+run.getWidth() >= 0.8*width) {
            cameraX -= vX;
        }
        else {
            x += vX;
        }
    }

    void stop() {
        if (!jumping) {
            if (movement == Movements.RIGHT) {
                movement = Movements.RIGHT_IDLE;
                currentAnimation = idle;
                facingLeft = false;
            }
            else if (movement == Movements.LEFT) {
                movement = Movements.LEFT_IDLE;
                currentAnimation = idle;
                facingLeft = true;
            }
        }
        else { continueJump(); }
    }

    void startJump() {
        if (movement == Movements.RIGHT || movement == Movements.RIGHT_IDLE) {
            movement = Movements.JUMP_RIGHT;
            facingLeft = false;
        }
        else if (movement == Movements.LEFT || movement == Movements.LEFT_IDLE) {
            movement = Movements.JUMP_LEFT;
            facingLeft = true;
        }
        currentAnimation = jumpStart;
        vY = jumpVel;
    }

    void continueJump() {
        if(abs(vY) > abs(ground - y) && vY < 0) {
            //if the movement will take it below ground, just set y to ground
            y = ground;
        }
        else { // otherwise move it normally
            y -= vY;
            vY -= gravity;
        }
        if (y >= ground) {
            jumping = false;
            vY = 0;
            if (movement == Movements.JUMP_RIGHT) {
                movement = Movements.RIGHT_IDLE;
                currentAnimation = idle;
                facingLeft = false;
            }
            else if (movement == Movements.JUMP_LEFT) {
                movement = Movements.LEFT_IDLE;
                currentAnimation = idle;
                facingLeft = true;
            }
        }
        else if (vY <= -jumpVel*0.5) {
            currentAnimation = jumpEnd;
            //finished with mid-jump anim, so reset it to the starting frame for next time
            jumpMid.reset();
        }
        else if (vY >= jumpVel * 0.5) {
            currentAnimation = jumpStart;
            //finished with end-jump anim, so reset it
            jumpEnd.reset();
        }
        else {
            currentAnimation = jumpMid;
            //finished with start-jump anim, so reset it
            jumpStart.reset();
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
        currentAnimation.display(x, y, facingLeft);
        currentAnimation.updateSprite();
    }
}