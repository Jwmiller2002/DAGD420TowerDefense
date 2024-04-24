class TowerBullet {

  private float x, y;
  public boolean isDead;
  private float towerType;

  private int target;
  private float bulletSpeed;
  private boolean hit=true;
  private float velocityX, velocityY =1;
  private float targetX, targetY;
  private float  bulletSize =10;
  

  TowerBullet(float towerType, float towerX, float towerY, float targetX, float targetY, int enemyNum, float bulletSpeed) {
    this.x=towerX;
    this.y=towerY;
    target = enemyNum;
    this.towerType = towerType;
    this.bulletSpeed = bulletSpeed;
    this.targetX=targetX;
    this.targetY=targetY;

    velocityX =x-targetX;
    velocityY =y-targetY;
  }
  void draw() {
    if (towerType ==3) rect(x, y, 20, 20);
    else rect(x, y, bulletSize, bulletSize);
    println("btime");

    x+=velocityX * bulletSpeed * DeltaTime;
    y+=velocityY* bulletSpeed * DeltaTime;

    if (hit) { //
      hitEnemy();
    }
  }
  public void hitEnemy() {
    if (towerType ==0) {//normmattack
      bulletSpeed =10;
      float distance = sqrt(sq(x - targetX) + sq(y-targetY));
      if (distance <=30) {
        //e.takeDamage(20);
      }
    } else if (towerType ==3) {//AOE
      bulletSize =30;
      bulletSpeed =0;
      float distance = sqrt(sq(x - targetX) + sq(y-targetY));
      if (distance <=30) {
        //e.takeDamage(20);
      }
    }
  }
}


/*else if (towerType ==4) {//repair
 Tower e = towers.get(target);
 e.health +=20;
 }*/
