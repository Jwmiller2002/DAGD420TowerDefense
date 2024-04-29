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

  public ArrayList<TowerBullet> bullets;


  public



    Tower(float pointOnGridX, float pointOnGridY, int type) {
    x= pointOnGridX-2;
    y = pointOnGridY-2;
    towerType = type;
    

    bullets = new ArrayList<TowerBullet>();
  }
  void draw() {

    //////println(health);
    if (towerType ==0 && doOnce) {
      //Basic Tower
      fireRange =300;

      maxHealth =50;
      health = maxHealth;
      firerate =1.5;
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =1;
    } else if (towerType ==1 && doOnce) {

      //RAM TOWER
      firerate = 6;
      maxHealth =25;
      health = maxHealth;
      ramCost = 2;
      energyCost = 5;
      ramTower =true;
      doOnce =false;
      supportTower =true;
    } else if (towerType ==2 && doOnce) {
      // Wall
      firerate =1;
      maxHealth =150;
      health = maxHealth;
      //println(supportTower);
      ramCost = 2;
      energyCost = 5;
      bulletSpeed =5;
      doOnce =false;
      supportTower =true;
    } else if (towerType ==3 && doOnce) {
      // AOE tower
      firerate = 3;
      maxHealth =20;
      health = maxHealth;
      fireRange =100;
      ramCost = 2;
      energyCost = 5;
      doOnce =false;
    } else if (towerType ==4 && doOnce) {
      //SUNFLOWER/MONEY,  Limited Lifetime?
      supportTower =true;
      maxHealth =30;
      health = maxHealth;
      ramCost = 2;
      energyCost = 5;
      doOnce =false;
    } else if (towerType ==5 && doOnce) {
      //CENTER PLACE
      maxHealth =100;
      health = maxHealth;
      supportTower =true;
      fill(111);
      //rect(x,y,32,32);
      doOnce =false;
    }


    // Code that works for all towers(checking health shooting ect.)


    //println(health);


    if (!foundEnemy && !supportTower) foundEnemy = chooseEnemy();
    //if(game.enemyMan.enemies.size()>0 )if(game.enemyMan.enemies.get(enemyToShoot).isDead)foundEnemy =false;

    if (timeTilNextFire <=0 && foundEnemy && !supportTower) {                //shootEnemy
      bullets.add(new TowerBullet(towerType, x, y, enemyX, enemyY, enemyToShoot, bulletSpeed));
      timeTilNextFire = random(firerate-0.5, firerate+0.5);

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
    for (int i=0; i<game.enemyMan.enemies.size(); i++) {
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
