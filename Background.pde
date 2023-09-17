class Background {

    PImage bg;
    float x = 0;
    float y = 0;
    float z;

    Background(String img, float z) {
        this.bg = loadImage(img);
        this.z = z;
    }

    void display() {
        image(bg, cameraX/z, y);
    }
}