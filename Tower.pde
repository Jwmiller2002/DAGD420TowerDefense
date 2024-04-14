class Tower {
  private float health;
  private float maxHealth;
  private boolean doOnce =true;

  private float firerate;
  private float timeTilNextFire;
  private float fireRange;

  private int towerType;
  private float towerDecayRate =5;
  private float decayDelay=10;
  public float towerCost=10;

  private float x, y =500;

  private float ramCost;
  private float energyCost;

  public boolean isDead = false;
  private boolean foundEnemy =false;

  public ArrayList<Enemy> enemies;


  Tower(float pointOnGrid, int type) {
    x= pointOnGrid;
    y = pointOnGrid;
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

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 1: //Support Tower
      firerate = 6;
      maxHealth =25;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 2: // Oil/slow enemy tower
      firerate =1;
      maxHealth =75;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 3: // electric/aoe tower
      firerate = 4;
      maxHealth =100;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 4: //Repair tower,  Limited Lifetime?
      firerate = 10;
      maxHealth =100;
      towerDecayRate =5;
      ramCost = 2;
      energyCost = 5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;

      // Code that works for all towers(checking health shooting ect.)

      if (doOnce) health = maxHealth;
      takeDamage();
      if (!foundEnemy) chooseEnemy();

      if (timeTilNextFire <=firerate && foundEnemy) { //shootEnemy
      }
    }


    //tower shooting and supoort
  }
  private void takeDamage() { //checkingDamage and decay damage/repairHealth
    //health --;  //change to subtract damage from enemy attack number

    if (decayDelay <=0) health--;
    else decayDelay -= towerDecayRate;

    if (health <=0)isDead = true;
  }
  private float chooseEnemy() { //get array of enemies and shoot neerest or the most leathal one
    for (int i=0; i<enemies.size()-1; i++) {
      Enemy e = enemies.get(i);
      float enemyDistanceFromTower = sqrt(sq(this.x + e.pos.x) + sq(this.y + e.pos.y));
      if (enemyDistanceFromTower <= fireRange) {
        foundEnemy =true;
        return i; //return enemy to shoot
      }
    }
    return -1;
  }
}
