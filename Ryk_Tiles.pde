class Tiles{
  float x, y, w, h;
  int property;
  
  
  Tiles(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void setProperty(int p){
    //Property 0 is Overclocked
    //Property 1 is Oil
    //Property 2 is Electric
    property = p;
    if(p == 0){
      //Increase the towers ability
      //increase the Enemy ability
      
      //Tower.Ability *= 1.15
      //Enemy.Ability *= 1.15
      
    } else if (p == 1){
      //If an enemy is over the tile, slow the enemy movement
      //If a tower is over the tile, When the Tower is destroyed, cause a burst Damage effect
      
      //Enemy.movement *= 0.8
      //Tower.dead deals 'c' Pixel area 'b' damage
    } else if (p == 2){
      //Deals 'b' damage per tick on tile to enemies and towers
      //
    } else if (p == 3){
      //Heals tower over time, tower attack speed slightly decreased
      //Heals enemies
      
      //tower.health += tower.maxHealth * 1.1
      //tower.attackspeed *= .9
      //enemy health += enemy.Maxhelath * 1.2
    } else {
      //No special effect
    }
  }
}