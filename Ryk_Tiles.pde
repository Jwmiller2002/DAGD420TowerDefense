class Tiles{
  private float x, y, w, h;
  private int property;
  
  boolean enemyOnTile;
  
  PImage basicTile;
  PImage overClock;
  PImage oil;
  PImage electric;
  PImage coolant;
  
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  
  Enemy enemy;
  Tower tower;
  
  Tiles(float x, float y){
    this.x = x;
    this.y = y;
    basicTile = loadImage("BaseTile.png");
    overClock = loadImage("Overclock.png");
    oil = loadImage("OilTile.png");
    electric = loadImage("Electric.png");
    coolant = loadImage("Coolant.png");
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
      
      //Tower.Ability *= 1.15
      //Enemy.Ability *= 1.15
      
      tower.firerate *= 1.2;
      enemy.speed *= 1.2;
      
      image(overClock, x, y);
      
    } else if (p == 1){
      //If an enemy is over the tile, slow the enemy movement
      //If a tower is over the tile, When the Tower is destroyed, cause a burst Damage effect
      
      //Enemy.movement *= 0.8
      //Tower.dead deals 'c' Pixel area 'b' damage
      
      image(oil, x, y);
      
    } else if (p == 2){
      //Deals 'b' damage per tick on tile to enemies and towers
      //
      
      image(electric, x, y);
      
    } else if (p == 3){
      //Heals tower over time, tower attack speed slightly decreased
      //Heals enemies
      
      //tower.health += tower.maxHealth * 1.1
      //tower.attackspeed *= .9
      //enemy health += enemy.Maxhelath * 1.2
      
      image(coolant, x, y);
    } else {
      //No special effect
      image(basicTile, x, y);
    }
  }
}
