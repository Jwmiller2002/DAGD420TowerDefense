class Tower {
  private float health;
  private float maxHealth;
  private boolean doOnce =true;

  private float firerate;
  private float timeTilNextFire;
  private float fireRange;
  public float bulletSpeed;

  private int towerType;
  private boolean supportTower =true;

  private float decayDelay=10;
  public float towerCost=10;
  public boolean buffed, slowed =false;

  private float EnergyChargeCooldown =2;

  public float x, y;
  private float enemyX, enemyY;

  private float ramCost;
  private float energyCost;
  public boolean ramIncreased =false;
  public boolean ramTower =false;

  public boolean isDead = false;
  private boolean foundEnemy =false;
  private int enemyToShoot;

  public ArrayList<TowerBullet> bullets;


  public



    Tower(float pointOnGridX, float pointOnGridY, int type) {
    x= pointOnGridX-2;
    y = pointOnGridY-2;
    towerType = type;
    if (type ==0 || type ==3) supportTower =false;

    bullets = new ArrayList<TowerBullet>();
  }
  void draw() {

    //////println(health);
    switch(towerType) {
    case 0: //Basic Tower
      fireRange =300;
      maxHealth =50;
      firerate =.5;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =1;


      ;
    case 1: //RAM TOWER
      firerate = 6;
      maxHealth =25;

      ramCost = 2;
      energyCost = 5;

      ramTower =true;


      ;
    case 2: // Wall
      firerate =1;
      maxHealth =200;

      //println(supportTower);
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =5;


    case 3: // AOE tower
      firerate = 2;
      maxHealth =100;
      fireRange =100;
      ramCost = 2;
      energyCost = 5;


      ;
    case 4: //SUNFLOWER/MONEY,  Limited Lifetime?

      maxHealth =100;

      ramCost = 2;
      energyCost = 5;
      ;


      // Code that works for all towers(checking health shooting ect.)

      if (doOnce) health = maxHealth;


      if (!foundEnemy) foundEnemy = chooseEnemy();
      //if(game.enemyMan.enemies.size()>0 )if(game.enemyMan.enemies.get(enemyToShoot).isDead)foundEnemy =false;

      if (timeTilNextFire <=0 && foundEnemy && !supportTower) {                //shootEnemy
        bullets.add(new TowerBullet(towerType, x, y, enemyX, enemyY, enemyToShoot, bulletSpeed));
        timeTilNextFire = random(firerate-1,firerate);
         
        ////println("SHOT");
      } else if (!supportTower) {
        timeTilNextFire -=1 *DeltaTime;//*dt; //fire reset
        //println(timeTilNextFire);
      }
      
      if (!supportTower) {
        for (int i=0; i<bullets.size(); i++) {
          bullets.get(i).draw();
          if (bullets.get(i).isDead) {
            bullets.remove(i);
          }
        }
      }



      if (buffed) {  //SUPPORT TOWER BUFF
        timeTilNextFire -=.5 * DeltaTime;
      } else if (slowed) {
        timeTilNextFire +=0.5 * DeltaTime;
      }
    }



    //tower shooting and supoort
  }
  public void takeDamage(float damage) { //checkingDamage and decay damage/repairHealth
    health -=damage;
    if (health <=0) {
      isDead = true;
      foundEnemy =false;
    }
  }
  private boolean chooseEnemy() { //get array of enemies and shoot neerest or the most leathal one
    for (int i=0; i<game.enemyMan.enemies.size()-1; i++) {
      Enemy e = game.enemyMan.enemies.get(i);
      float enemyDistanceFromTower = sqrt(sq(this.x - e.pos.x) + sq(this.y - e.pos.y));
      ////println(enemyDistanceFromTower);
      if (enemyDistanceFromTower <= fireRange) {
        enemyToShoot = i;
        enemyX =e.pos.x;
        enemyY =e.pos.y;
        ////println("ENEMYFOUND");
        return true; //return enemy to shoot
      }
    }
    return false;
  }
  private void helpNearTowers() {
    for (int i=0; i<towers.size(); i++) {
      Tower e = towers.get(i);
      float DistanceFromOtherTower = sqrt(sq(this.x + e.x) + sq(this.y + e.y));
      if (DistanceFromOtherTower <=fireRange) {
        bullets.add(new TowerBullet(x, y, e.x, e.y, towerType, i, bulletSpeed));
      }
    }
  }
}
