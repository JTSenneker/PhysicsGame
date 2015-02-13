class Camera {
  float zoom = 1;
  Vec2 pos;
  PMatrix2D matrix = new PMatrix2D();

  void update() {
    pos = platform.getPosition().add(new Vec2(0,-100));
    matrix.reset();
    matrix.translate(width/2, height/2);
    matrix.scale(zoom); //zoom
    matrix.translate(-pos.x, -pos.y);// 1 move to world origin
  }
  PVector transormInverseMatrix(PVector v) {
    v = v.get();
    //do math
    PMatrix2D im = matrix.get();// copy of matrix
    im.invert(); //inverts matrix
    im.mult(v,v);
    return v;
  }
}

