import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

class Cloud {
  float speed;
  Vec2 position;
  float angle; 
  float w;
  float h;
  String spriteImage;
  Sprite sprite;
  Body body;

  Cloud(Vec2 position, float w, float h, String spriteImage, float speed) {
    sprite = new Sprite(spriteImage);
    angle = random(0,2*PI);
    this.h = h;
    this.w = w;
    this.position = position;
    this.speed = speed;
    if (position.x > platform.getPosition().x){
     this.speed = -1; 
    }else speed = 1;
    // body = makeACircle(new Vec2(400, 0), 10, false);
  }
  public void update() {
    position = body.getPosition();
    sprite.position = this.position;
    sprite.rotation = angle;
    position.x += speed;
    body.setTransform(position,angle);
  }
  public void draw() {
    sprite.draw();
  }
}

