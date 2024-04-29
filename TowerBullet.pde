class TowerBullet {

  private float x, y;
  public boolean isDead;
  private float towerType;
  private float bulletLifetime =5;
  private float aoeLifetime =1;
  private boolean canShoot =true;
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


    velocityX =targetX-x;
    velocityY =targetY-y;
  }
  void draw() {


    if (towerType ==3) fill(20, 200, 50);
    else fill(20, 100, 20);
    ellipse(x+16, y+16, bulletSize, bulletSize);
    ////println("btime");

    x+=velocityX * bulletSpeed * DeltaTime;
    y+=velocityY* bulletSpeed * DeltaTime;

    hitEnemy();
  }
  public void hitEnemy() {
    //if(game.enemyMan.enemies.size() <1) return;
    float distance = sqrt(sq(x - targetX) + sq(y-targetY));
    if (towerType ==0) {//normmattack
      bulletSpeed = random(8, 10);
      if (distance <=bulletSize && game.enemyMan.enemies.size() >target) {
        game.enemyMan.enemies.get(target).takeDamage(12.5);
        isDead = true;
      }
      if (bulletLifetime <=0) isDead =true;
      else bulletLifetime -=1*DeltaTime;
    } else if (towerType ==3 ) {//AOE
      bulletSize =180;
      bulletSpeed =0;
      if (canShoot) {
        for (int i=0; i<game.enemyMan.enemies.size(); i++) {
          if (game.enemyMan.enemies.size() < i) return;
          distance = sqrt(sq(x - game.enemyMan.enemies.get(i).pos.x) + sq(y-game.enemyMan.enemies.get(i).pos.y));
          if (distance <=bulletSize/2) {
            game.enemyMan.enemies.get(i).takeDamage(25);
          }
        }
        canShoot =false;
      }
      if (aoeLifetime <=0) {
        isDead =true;
        aoeLifetime =0.5;
      } else aoeLifetime -=1*DeltaTime;
    }
  }
}


/*else if (towerType ==4) {//repair
 Tower e = towers.get(target);
 e.health +=20;
 }*/
