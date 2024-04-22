class TileProperty{
  private float x, y, w, h;
  int property;
  
  boolean enemyOnTile;
  boolean towerOnTile;
  boolean goalTarget;
  boolean enemySpawner;
  
  PImage basicTile;
  PImage overClock;
  PImage oil;
  PImage electric;
  PImage coolant;
  PImage spawner;
  PImage goal;
  
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  
  Enemy enemy;
  Tower tower;
  
  TileProperty(float x, float y){
    this.x = x;
    this.y = y;
    basicTile = loadImage("BaseTile.png");
    overClock = loadImage("Overclock.png");
    oil = loadImage("OilTile.png");
    electric = loadImage("Electric.png");
    coolant = loadImage("Coolant.png");
    spawner = loadImage("SpawnTile.png");
    goal = loadImage("GoalTile.png");
    
    //enemy = new Enemy(x, y);
    //tower = new Tower();
  }
  
  void setProperty(int p){
    //Property 0 is Overclocked
    //Property 1 is Oil
    //Property 2 is Electric
    //Property 3 is Collant
    //Property E is Base tile
    property = p;
    
    if(p == 0){
      //Increase the towers ability
      //increase the Enemy ability
      
      /*tower.firerate *= 1.2;
      enemy.speed *= 1.2;
      */
      image(overClock, x, y, 32, 32);
      
    } else if (p == 1){
      //If an enemy is over the tile, slow the enemy movement
      //If a tower is over the tile, When the Tower is destroyed, cause a burst Damage effect
      //Tower.dead deals 'c' Pixel area 'b' damage
      
      //enemy.speed *= 0.8;
      
      image(oil, x, y, 32, 32);
      
    } else if (p == 2){
      //Deals 'b' damage per tick on tile to enemies and towers
      
      //enemy.health -= 0.02 * enemy.healthMax;
      //tower.health -= 0.02 * tower.maxHealth;
      
      image(electric, x, y, 32, 32);
      
    } else if (p == 3){
      //Heals tower over time, tower attack speed slightly decreased
      //Heals enemies
      
      //tower.health += tower.maxHealth * 1.1
      //tower.attackspeed *= .9
      //enemy health += enemy.Maxhelath * 1.2
      
      //tower.health += tower.maxHealth * 1.1;
      //tower.firerate *= 0.9;
      
      //enemy.health += enemy.healthMax;
      
      image(coolant, x, y, 32, 32);
      
    } else if (p == 4){
      
      image(spawner, x, y, 32, 32);
      
      enemySpawner = true;
    } else if (p == 5){
      
      image(goal, x, y, 32, 32);
      
      goalTarget = true;
    }
    else {
      //No special effect
      image(basicTile, x, y);
    }
  }
}
