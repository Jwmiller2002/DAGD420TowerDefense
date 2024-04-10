class Tower {
  private float health;
  private float maxHealth;
  private boolean doOnce =true;

  private float firerate;
  private float timeTilNextFire;

  private int towerType;
  private float towerDecayRate =5;
  private float decayDelay=10;

  private float x, y =500;

  public boolean isDead = false;
  private boolean foundEnemy =false;
  Tower(float pointOnGrid, int type) {
    x= pointOnGrid;
    y = pointOnGrid;
    towerType = type;
  }
  void draw() {
    println(health);
    switch(towerType) {
    case 0: //Basic Tower
      maxHealth =50;
      firerate =3;
      towerDecayRate =5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 1: //Support Tower
      firerate = 6;
      maxHealth =25;
      towerDecayRate =5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 2: // Oil/slow enemy tower
      firerate =1;
      maxHealth =75;
      towerDecayRate =5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 3: // electric/aoe tower
      firerate = 4;
      maxHealth =100;
      towerDecayRate =5;

      fill(50, 255, 100);
      rect(x, y, 20, 20);
      ;
    case 4: //Repair tower,  Limited Lifetime?
      firerate = 10;
      maxHealth =100;
      towerDecayRate =5;

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
    if (foundEnemy) {
      foundEnemy =true;
      return 1; //return enemy to shoot
    }
    return 0;
  }
}
