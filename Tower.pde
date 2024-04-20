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
  private float towerDecayRate =5;
  private float decayDelay=10;
  public float towerCost=10;
  public float supportBuffTimer =0;
  
  private float EnergyChargeCooldown =2;

  private float x, y =500;
  private float enemyX, enemyY;

  private float ramCost;
  private float energyCost;

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
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =10;

     
      ;
    case 1: //Support Tower
      firerate = 6;
      maxHealth =25;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;
      supportTower =true;
      bulletSpeed =10;

      
      ;
    case 2: // Oil/slow enemy tower
      firerate =1;
      maxHealth =75;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =5;

      
    case 3: // electric/aoe tower
      firerate = 4;
      maxHealth =100;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;

      
      ;
    case 4: //SUNFLOWER/MONEY,  Limited Lifetime?
      firerate = 10;
      maxHealth =100;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;
     

      
      ;

      // Code that works for all towers(checking health shooting ect.)

      if (doOnce) health = maxHealth;

      takeDamage();
      if (!foundEnemy) foundEnemy = chooseEnemy();

      if (timeTilNextFire <=0 && foundEnemy && !supportTower) {                //shootEnemy
        bullets.add(new TowerBullet(x, y, enemyX, enemyY, towerType, enemyToShoot, bulletSpeed));
        timeTilNextFire =firerate;
      } 
      
      else if (timeTilNextFire <=0 && supportTower) { //SUPPORT TOWER
        helpNearTowers();
        timeTilNextFire =firerate;
      } else timeTilNextFire -=1 *DeltaTime;//*dt;
      
      
      if(supportBuffTimer >0){  //SUPPORT TOWER BUFF
        timeTilNextFire -=1 * DeltaTime;
        supportBuffTimer-= 1* DeltaTime;
      }
      
      
    }


    //tower shooting and supoort
  }
  private void takeDamage() { //checkingDamage and decay damage/repairHealth
    //health --;  //change to subtract damage from enemy attack number

    if (decayDelay <=0) health--;
    else decayDelay -= towerDecayRate;

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
