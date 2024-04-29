class EnemySlow extends Enemy {

  float slowRadius;

  EnemySlow(float h, float d, float s, PVector p, Tile go) {
    super(h, d, s, p, go);
    slowRadius=50;
  }

  void update() {
    super.update();
    for (Tower t : towers) {
      float xdif = t.x-pos.x;
      float ydif = t.y-pos.y;
      if (sqrt(xdif*xdif+ydif*ydif)<slowRadius) {
        t.timeTilNextFire +=.5;
      }
    }
  }//end update

  void draw() {
    stroke(20);
    strokeWeight(5);
    fill(30, 200, 250);
    ellipse(pos.x, pos.y, 30, 30);
    noStroke();
    fill(30, 200, 250, 80);
    ellipse(pos.x, pos.y, slowRadius*2, slowRadius*2);
    //drawPath();
  }
}
