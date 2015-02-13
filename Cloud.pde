import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

class Cloud {
  Vec2 position;
  float angle; 
  float w;
  float h;
  String spriteImage;
  Sprite sprite;
  Body body;

  Cloud(Vec2 position, float w, float h, String spriteImage) {
    sprite = new Sprite(spriteImage);
    this.h = h;
    this.w = w;
    this.position = position;
    // body = makeACircle(new Vec2(400, 0), 10, false);
  }
  public void update() {
    angle = body.getAngle();
    position = body.getPosition();
    sprite.position = this.position;
  }
  public void draw() {
    sprite.draw();
  }
}

