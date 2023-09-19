class Animation{
    PImage[] images; //array of images
    int[] durations; //array of delays for displaying each image/frame
    int imageCount;
    int currentFrame;
    int currentDuration; //in milliseconds
    boolean loopAnim;
    PImage spriteSheet;
    int lastChangeTime = 0;
    
    /**
    *Constructor for the Animation class
    *@param spriteLink string of relative path to file, without file extension (eg "character/idle" for "character/idle.png")
    *@param loopAnim boolean for whether or not your animation loops
    */
    Animation(String spriteLink, boolean loopAnim) {
        JSONObject animObject = loadJSONObject(spriteLink + ".json"); //loads the json file for the spritesheet
        JSONArray frames = animObject.getJSONArray("frames"); //a JSONArray object which contains frame info for each part in animObject
        this.loopAnim = loopAnim;
        imageCount = frames.size();
        spriteSheet = loadImage(spriteLink + ".png"); //loads the spriteSheet image from file
        currentFrame = 0; //resets the current frame
        makeImageArray(frames);
        currentDuration = durations[0]; //resets the current frame duration
    }
    
    /**
    *Makes an array of PImages based on the spriteSheet and the associated info in the JSONArray
    *Also makes an array of durations of each frame/image based on the info in the JSONArray
    *@param frames the JSONArray of information from sprites .json
    */
    void makeImageArray(JSONArray frames) {
        //create arrays with the right size (the amount of frames)
        images = new PImage[imageCount]; 
        durations = new int[imageCount];
        
        for (int i = 0; i < imageCount; i++) {
            //makes a jsonObject based on the current information for that part of the .json
            JSONObject frameData = frames.getJSONObject(i);
            
            int x = frameData.getJSONObject("frame").getInt("x"); //gets x value
            int y = frameData.getJSONObject("frame").getInt("y"); //gets y value
            int w = frameData.getJSONObject("frame").getInt("w"); //gets width of frame image
            int h = frameData.getJSONObject("frame").getInt("h"); //gets height of frame image
            int duration = frameData.getInt("duration"); //gets duration of frame (in ms)
            
            //makes a PImage based on the cropped section of the spritesheet using the x,y,w and h
            PImageframe = spriteSheet.get(x, y, w, h);
            
            images[i] = frame; //makes that index of the images array be that frame
            durations[i] = duration; //makes that index of the durations array be that duration
        }
    }
    
    /**
    *Increment the frame if certain conditions are met
    *Conditions include whether the animation is set to loop or not, and if not, whether it's finished;
    *and whether the JSON-specified duration of the current frame has passed yet.
    */
    void updateSprite() {
        int currentTime = millis(); // number of milliseconds since starting the sketch
        
        // checkif time to change frame (if time since last changing is >= the specified duration)
        if (currentTime - lastChangeTime > currentDuration) {
            // if theanimation is set to loop
            if (loopAnim) {
                currentFrame = (currentFrame + 1) % imageCount; // increment the frame, and go to start if at end
                currentDuration = durations[currentFrame]; // update the frame duration for the new frame
                lastChangeTime = currentTime; // update the time the frame was last changed
            }
            else { // if the animation should only run through once
                if (currentFrame < imageCount - 1) { // only do this if the animation isn't finished yet
                    currentFrame++; // increment the frame
                    currentDuration = durations[currentFrame];
                    lastChangeTime = currentTime;
                }
            }
        }
    }
    
    /**
    *Display thecurrent frame for this animation, facing the correct direction, at x and y
    *@param x the x coordinate at which to draw the top left of the image
    *@param y the y coord at which to draw top left of image
    *@param faceLeft whether the sprite should be facing left or not facing left (facing right)
    */
    void display(float x, float y, boolean faceLeft) {
        PImage img = images[currentFrame];
        if (faceLeft) {
            pushMatrix(); // store current coord system
            scale( -1.0, 1.0); // scale with x factor of -1 (ie flip horizontally)
            image(img, -(x + img.width), y); //make sure it's drawn in the right place visually
            popMatrix();// retrieve prior coord system
        }
        else {
            image(img, x, y); //draw as is (facing right) at given coords
        }
    }
    
    /**
    *Gets the width of (the current frame of) the sprite
    *@return  width of the sprite as an int
    */
    int getWidth() {
        return images[currentFrame].width;
    }
    
    /** 
    *Resets current frame to the start of the animation
    *Useful for non - looping animations
    */
    void reset() {
        currentFrame = 0;
    }
}