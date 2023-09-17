class Player {
    
    Animation idleRight = new Animation(loadJSONObject("character/Idle.json"), true, "character/Idle.png");
    Animation idleLeft = new Animation(loadJSONObject("character/Idle_l.json"), true, "character/Idle_l.png");
    Animation runRight = new Animation(loadJSONObject("character/Run.json"), true, "character/Run.png");
    Animation runLeft = new Animation(loadJSONObject("character/Run_l.json"), true, "character/Run_l.png");
    Animation currentAnimation = idleRight;
    Movements movement = Movements.RIGHT_IDLE;
    float x = 50;
    float vX = 5;
    float y = 200;

    Player(float x, float y) {
        this.x = x;
        this.y = y;
    }

    Movements getMovement() {
        return movement;
    }

    void moveLeft() {
        movement = Movements.LEFT;
        currentAnimation = runLeft;
        x -= vX;
    }

    void moveRight() {
        movement = Movements.RIGHT;
        currentAnimation = runRight;
        x += vX;
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

    float getX() {
        return x;
    }
    float getY() {
        return y;
    }

    void display() {
        currentAnimation.display(x, y);
        currentAnimation.updateSprite();
    }
}