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
      chooseEnemy();
    }
    //tower shooting and supoort
  }
  private void takeDamage() { //checkingDamage and decay damage/repairHealth
    //health --;  //change to subtract damage from enemy attack number

    if (decayDelay <=0) health--;
    else decayDelay -= towerDecayRate;
  }
  private float chooseEnemy() { //get array of enemies and shoot neerest or the most leathal one

    return 1;
  }
}
