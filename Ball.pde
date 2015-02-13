import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

class Ball {
  Vec2 position;
  float angle; 
  float radius;
  String spriteImage;
  Sprite sprite;
  Body body;

  Ball(Vec2 position, float radius, String spriteImage) {
    sprite = new Sprite(spriteImage);
    this.radius = radius;
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

  Body makeACircle(Vec2 pos, float radius, boolean isFixed) {
    BodyDef def = new BodyDef();
    def.type = isFixed ? BodyType.STATIC : BodyType.DYNAMIC;
    def.position = pos;
    //def.linearVelocity = new Vec2(0,-50);

    Body body = world.createBody(def);

    CircleShape shape = new CircleShape();
    shape.m_radius = radius;

    FixtureDef fixture = new FixtureDef();
    fixture.shape = shape;
    fixture.density = 100000;
    fixture.friction = 0.5;
    fixture.restitution = 2;
    body.m_gravityScale = 1;
    body.createFixture(fixture);
    return body;
  }
}

