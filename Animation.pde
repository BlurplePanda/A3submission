class Animation{
  PImage[] images; //array of images
  int[] durations; //array of delays for displaying each image/frame
  int imageCount;
  int currentFrame;
  int currentDuration;
  boolean loopAnim;
  PImage spriteSheet;
  int lastChangeTime = 0;

  /**
   * Constructor for the Animation class
   * @param animObject the JSONObject for your sprites.json, can be passed through via loadJSONObject(name.json)
   * @param loopAnim boolean for whether or not your animation loops, helpful under some circumstances but up to you to implement
   * @param spriteSheetLink string for the image link for your spritesheet (e.g "img/sprite.png") can be replaced with a PImage but up to you
   * I recommend reading the processing documentation for any part that confuses you
   */
  Animation(JSONObject animObject, boolean loopAnim, String spriteSheetLink){
    JSONArray frames = animObject.getJSONArray("frames"); //a JSONArray object which contains frame information for each part in the animObject JSON
    this.loopAnim = loopAnim;
    imageCount = frames.size();
    spriteSheet = loadImage(spriteSheetLink);             //loads the spriteSheet image and assigns it to a field
    currentFrame = 0;                                     //resets the current frame
    makeImageArray(frames);                               //calls the makeImageArray method to generate the array of Images
    currentDuration = durations[0];
  }

  /**
   * Makes an array of PImages based on the spriteSheet and the associated info in the JSONArray
   * @param frames the JSONArray of information from your sprites .json
   */
  void makeImageArray(JSONArray frames){
    images = new PImage[imageCount];                     //makes the images field a new PImage array with a size of the amount of frames 
    durations = new int[imageCount];
    for (int i = 0; i < imageCount; i++) {
      JSONObject frameData = frames.getJSONObject(i);       // makes a jsonObject based on the current information for that part of the .json
      int x = frameData.getJSONObject("frame").getInt("x"); //gets the value for the x
      int y = frameData.getJSONObject("frame").getInt("y"); //gets the value for the y
      int w = frameData.getJSONObject("frame").getInt("w"); //gets the value for the w
      int h = frameData.getJSONObject("frame").getInt("h"); //gets the value for the h
      int duration = frameData.getInt("duration");
      PImage frame = spriteSheet.get(x, y, w, h);           //makes a PImage based on the cropped section of the spritesheet using the x,y,w and h
      images[i] = frame;                                    //makes that index of the images array be that frame
      durations[i] = duration;
    }
  }

  /**
   * move the {@link #currentFrame} based on your conditions, up to you to write
   */
  void updateSprite(){
    int currentTime = millis();
    if (currentTime - lastChangeTime > currentDuration) {
        currentFrame = (currentFrame+1) % imageCount;
        currentDuration = durations[currentFrame];
        lastChangeTime = currentTime;
    }
  }

  /**
   * display the current frame for this animation at x and y
   */
  void display(float x, float y){
    image(images[currentFrame], x, y);
  }
}