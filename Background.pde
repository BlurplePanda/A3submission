class Background {
    
    PImage bg; //the image to display
    int y = 0;
    int z;
    
    /**
    * Constructor for the Background class
    * @param img the path of the image to display
    * @param z the "depth" of the image layer
    */
    Background(String img, int z) {
        this.bg = loadImage(img);
        this.z = z;
    }
    
    /**
    * Display the image
    * Display it 3 times (once where you are and once on left and right) to avoid visual gaps
    * Divides the "camera" pos by the depth of the layer to give impression of distant movement. (parallax)
    */
    void display() {
        image(bg, cameraX / z % bg.width - bg.width, y);
        image(bg, cameraX / z % bg.width, y);
        image(bg, cameraX / z % bg.width + bg.width, y);
    }
}