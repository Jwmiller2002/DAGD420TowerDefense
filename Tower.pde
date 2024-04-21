class Tower {
  private float health;
  private float maxHealth;
  private boolean doOnce =true;

  private float firerate;
  private float timeTilNextFire;
  private float fireRange;
  public float bulletSpeed;

  private int towerType;
  private boolean supportTower =false;

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
  public ArrayList<Enemy> enemies;
  public ArrayList<TowerBullet> bullets;


  public



    Tower(float pointOnGridX, float pointOnGridY, int type) {
    x= pointOnGridX;
    y = pointOnGridY;
    towerType = type;
    enemies = new ArrayList<Enemy>();
  }
  void draw() {
    println(health);
    switch(towerType) {
    case 0: //Basic Tower
      maxHealth =50;
      firerate =3;
      supportTower =false;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =10;


      ;
    case 1: //RAM TOWER
      firerate = 6;
      maxHealth =25;
      supportTower =true;
      ramCost = 2;
      energyCost = 5;
      supportTower =true;
      bulletSpeed =10;
      ramTower =true;


      ;
    case 2: // Wall
      firerate =1;
      maxHealth =200;
      supportTower =true;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =5;


    case 3: // AOE tower
      firerate = 4;
      maxHealth =100;
      supportTower =false;
      ramCost = 2;
      energyCost = 5;


      ;
    case 4: //SUNFLOWER/MONEY,  Limited Lifetime?
      firerate = 10;
      maxHealth =100;
      supportTower =true;
      ramCost = 2;
      energyCost = 5;



      ;

      // Code that works for all towers(checking health shooting ect.)

      if (doOnce) health = maxHealth;


      if (!foundEnemy) foundEnemy = chooseEnemy();

      if (timeTilNextFire <=0 && foundEnemy && !supportTower) {                //shootEnemy
        bullets.add(new TowerBullet(x, y, enemyX, enemyY, towerType, enemyToShoot, bulletSpeed));
        timeTilNextFire =firerate;
      } else if (supportTower !=false) { 
        timeTilNextFire -=1 *DeltaTime;//*dt; //fire reset
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
    for (int i=0; i<enemies.size()-1; i++) {
      Enemy e = enemies.get(i);
      float enemyDistanceFromTower = sqrt(sq(this.x + e.pos.x) + sq(this.y + e.pos.y));
      if (enemyDistanceFromTower <= fireRange) {
        enemyToShoot = i;
        enemyX =e.pos.x;
        enemyY =e.pos.y;
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
