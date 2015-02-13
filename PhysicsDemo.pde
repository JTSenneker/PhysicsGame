import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

Ball ball;
float speed;
float maxSpeed = 5;
float timer = 3.0f;
World world;
float timeStep = 1.0/30;
float speedY;
Vec2 platformPosition = new Vec2(400,300);


ArrayList<Cloud> clouds = new ArrayList<Cloud>();
ArrayList<Body> boxBodies = new ArrayList<Body>();
ArrayList<Body> circleBodies = new ArrayList<Body>();
Vec2 pos = platformPosition;
Body mainBox;
Camera cam = new Camera();
Body platform;

void setup() {
  ball = new Ball(new Vec2(),32,"ball.png");
  size(800, 500);
  world = new World(new Vec2(0, 10));
  platform =makeABox(new Vec2(400, 300), 30,10, true);
  //mainBox = makeACircle(new Vec2(400, 0), 10, false);
  ball.body = makeACircle(new Vec2(400,0),10,false);
  
  
  //circleBodies.add(mainBox);
  boxBodies.add(platform);
}

void update() {
  float deltaTime = millis()/1000.0;
  world.step(timeStep, 6,3);
  timer -= deltaTime;
  ball.update();
  if(timer <= 0){
     Cloud c = new Cloud(new Vec2(cam.pos.x + 10, cam.pos.y),57,26,"cloud.png"); 
  }
  //platformPosition.x ++;
  if(Keys.RIGHT) speed++;
  if(Keys.LEFT) speed--;
  platformPosition.x += speed;
  if (speed >= maxSpeed) speed = maxSpeed;
  speed *= .95f;
  platform.setTransform(platformPosition,platform.getAngle());
  cam.update();
}

void draw() {
  update();
  background(0);
  pushMatrix();
  applyMatrix(cam.matrix);
  /*for (Body body = world.getBodyList();body != null;body = body.getNext()) {
   drawBody(body);
   }*/
   ball.draw();
  for (Body b : boxBodies) {
    drawBody(b);
  }
  for (Body b : circleBodies) {
    drawCircleBody(b);
  }
  popMatrix();
}

void drawBody(Body body) {
  PolygonShape ps = (PolygonShape)body.getFixtureList().getShape(); 
  //CircleShape cs = (CircleShape)body.getFixtureList().getShape();
  Vec2[] verts = ps.getVertices();
  Vec2 pos = body.getPosition();

  noStroke();
  if (body.isAwake())fill(255);
  else fill(127);


  pushMatrix();
  translate(pos.x, pos.y);
  rotate(body.getAngle());
  beginShape();
  for (int i = 0; i < ps.getVertexCount(); i++) {
    vertex(verts[i].x, verts[i].y);
  }
  endShape();
  popMatrix();
}

void drawCircleBody(Body body) {
  //PolygonShape ps = (PolygonShape)body.getFixtureList().getShape(); 
  CircleShape cs = (CircleShape)body.getFixtureList().getShape();
  //Vec2[] verts = cs.getVertices();
  Vec2 pos = body.getPosition();

  noStroke();
  fill(255);



  pushMatrix();
  translate(pos.x, pos.y);
  rotate(body.getAngle());
  ellipse(0, 0, cs.m_radius*2, cs.m_radius*2);
  popMatrix();
}

Body makeABox(Vec2 pos, float w, float h, boolean isFixed) {
  BodyDef def = new BodyDef();
  def.type = isFixed ? BodyType.STATIC : BodyType.DYNAMIC;
  def.position = pos;

  Body body = world.createBody(def);

  PolygonShape shape = new PolygonShape();
  shape.setAsBox(w, h);

  FixtureDef fixture = new FixtureDef();
  fixture.shape = shape;
  fixture.density = 3;
  fixture.friction = .5;
  fixture.restitution = 1;

  body.createFixture(fixture);
  return body;
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
  fixture.density = 0;
  fixture.friction = 0.5;
  fixture.restitution = 2;
  //body.m_gravityScale = 2;
  body.createFixture(fixture);
  return body;
}

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  mouse = cam.transormInverseMatrix(mouse);

  Body box = makeACircle(new Vec2(mouse.x, mouse.y), 10, false);
  circleBodies.add(box);
}

