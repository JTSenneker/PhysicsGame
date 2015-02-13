class Sprite {
  Vec2 origin;
  float scale =1;
  float rotation;

  PImage img;
  Vec2 position = new Vec2();

  public Sprite(String file) {
    this.img = loadImage(file);
    centerOrigin();
  }



  void draw() {
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    scale(scale);
    image(img, -origin.x, -origin.y);
    popMatrix();
  }

  void centerOrigin() {
    origin = new Vec2(img.width/2,img.height/2);
  }
}

