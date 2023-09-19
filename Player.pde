class Player {
    // animations
    Animation idle = new Animation("character/Idle", true);
    Animation run = new Animation("character/Run", true);
    Animation jumpStart = new Animation("character/Jump-Start", false);
    Animation jumpMid = new Animation("character/Jump-Mid", false);
    Animation jumpEnd = new Animation("character/Jump-End", false);
    // if the player is facing left or not at current moment
    boolean facingLeft = false;
    // other fields
    Animation currentAnimation = idle; // current animation that sprite is using
    Movements movement = Movements.RIGHT_IDLE; // current state of movement
    float x;
    float vX = 5; //horizontal velocity
    float y;
    float vY = 0; //vertical velocity
    float jumpVel = 3; //initial vertical velocity of jump
    float gravity = 0.1; //gravity factor
    // y level the "ground" is at - not the actual ground level
    //this is the y the player's y will be equal to when the player is on the ground
    float ground = 200;
    
    /**
    * Constructor for the Player class
    * @param x initial x (horizontal) position of player
    * @param y initial y (vertical position of player) - note 0 is screen top, not bottom
    */
    Player(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    /**
    * Gets the player's current state of movement
    * @return the movement state as a Movement (enum)
    */
    Movements getMovement() {
        return movement;
    }
    
    /**
    * Moves the player (or camera) left a set distance
    * Does different things if jumping than on ground but works for both
    */
    void moveLeft() {
        facingLeft = true; //update the player direction to left (for animations)
        if (jumping) {
            movement = Movements.JUMP_LEFT; //update the movement state
            continueJump(); //do jumpy things (incl setting animation)
        }
        else {
            movement = Movements.LEFT;
            currentAnimation = run; //set animation to running
        }
        if (x <= 0.2 * width) { // if character is 20% or less of the screen width away from the left side
            cameraX += vX; //move the camera instead of player to simulate movement
        }
        else {
            x -= vX;//move player
        }
    }
    
    /**
    * Moves the player (or camera) right a set distance
    * Does different things if jumping than on ground but works for both
    */
    void moveRight() {
        facingLeft = false; //update player direction to right
        if (jumping) {
            movement = Movements.JUMP_RIGHT;
            continueJump();
        }
        else {
            movement = Movements.RIGHT;
            currentAnimation = run;
        }
        if (x + run.getWidth() >= 0.8 * width) { //if (right side of) player is <=(20% of screen width) from right side
            cameraX -= vX; //move camera instead
        }
        else {
            x += vX; 
        }
    }
    
    /**
    * Stop the player - change animations to idle etc
    * Doesn't do this if they are in the air as they should still stay in the jump state
    */
    void stop() {
        if (!jumping) {
            if (movement == Movements.RIGHT) { //if player was running right
                movement = Movements.RIGHT_IDLE; //make it stand facing right instead
                currentAnimation = idle;
                facingLeft = false;
            }
            else if (movement == Movements.LEFT) {
                movement = Movements.LEFT_IDLE;
                currentAnimation = idle;
                facingLeft = true;
            }
        }
        else { continueJump(); } //if player is jumping, do special jump things
    }
    
    /**
    * Starts the player's jump cycle:
    * Sets velocity to initial jump velocity and changes animation
    */
    void startJump() {
        currentAnimation = jumpStart;
        vY = jumpVel;
    }
    
    /**
    * Controls what the character does while in the process of jumping
    * Changes animations and states according to how far it is off the ground/through the jump
    * Increments jump by changing y and y velocity (to simulate gravity)
    */
    void continueJump() {
        if (abs(vY) > abs(ground - y) && vY < 0) {
            //if the movement will take it below ground, just set y to ground
            y = ground;
        }
        else { // otherwise move it normally
            y -= vY;
            vY -= gravity;
        }
        // animation(/state) changing
        if (y >= ground) { //if player is on the ground (ie finished jump)
            jumping = false;
            vY = 0;
            //change to idle
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
        else if (vY <= -jumpVel * 0.5) { //if player is in the "last bit" of the jump (going down fast)
            currentAnimation = jumpEnd;
            //finished with mid-jump anim, so reset it to the starting frame for next time
            jumpMid.reset();
        }
        else if (vY >= jumpVel * 0.5) { // "first bit" of the jump (going up fast)
            currentAnimation = jumpStart;
            //finished with end-jump anim, so reset it
            jumpEnd.reset();
        }
        else { // mid-jump
            currentAnimation = jumpMid;
            //finished with start-jump anim, so reset it
            jumpStart.reset();
        }
    }
    
    /**
    * Gets the player's x coordinate
    * @return x coord of player
    */
    float getX() {
        return x;
    }
    
    /**
    * Gets the player's y coordinate
    * @return y coord of player
    */
    float getY() {
        return y;
    }
    
    /**
    * Display (the current frame of) the sprite animation
    * and attempt to increment the animation
    */
    void display() {
        currentAnimation.display(x, y, facingLeft);
        currentAnimation.updateSprite();
    }
}