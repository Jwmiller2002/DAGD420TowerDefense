class TowerBullet {
  private float x, y;
  public boolean isDead;
  private float towerType;
  public ArrayList<Enemy> enemies;
  private int target;
  private float bulletSpeed;
  private boolean hit=true;
  private float velocityX,velocityY =1;


  TowerBullet(float towerType, float towerX, float towerY, int enemyNum, float bulletSpeed) {
    this.x=towerX;
    this.y=towerY;
    target = enemyNum;
    this.towerType = towerType;
    this.bulletSpeed = bulletSpeed;
  }
  void draw() {
    if(towerType ==3) rect(x, y, 20, 20);
    else rect(x, y, 10, 10);
    
    x+=velocityX;
    y+=velocityY;
    
    if (hit) { //
      hitEnemy();
    }
  }
  public void hitEnemy() {
    if (towerType ==0) {//normmattack
      //damageEnemy
    } else if (towerType ==1) { //Support(damage/firespeed
    Tower e = towers.get(target);
    e.supportBuff =true;
    } else if (towerType ==2) {//slow
    } else if (towerType ==3) {//AOE
    } else if (towerType ==4) {//repair
    Tower e = towers.get(target);
    e.health +=20;
    }
  }
}
