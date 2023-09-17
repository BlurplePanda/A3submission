class Background {

    PImage bg;
    int x = 0;
    int y = 0;
    int z;

    Background(String img, int z) {
        this.bg = loadImage(img);
        this.z = z;
    }

    void display() {
        image(bg, cameraX/z % bg.width - bg.width, y);
        image(bg, cameraX/z % bg.width, y);
        image(bg, cameraX/z % bg.width + bg.width, y);
    }
}