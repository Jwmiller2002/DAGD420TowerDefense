class Enemy{
  
  float health;
  float healthMax;
  float damage;
  float speed;
  PVector pos;//pixel position
  ArrayList<Tile> path; 
  Tile goalT;
  Tile nextTile;
  boolean findPath = false;
  
  float attackTimer;
  float attackCooldown;
  
  Point gridP = new Point(); // current position
  Point gridT = new Point();

  
  Enemy(float h,float d, float s, PVector p, Tile go){
    healthMax=h;
    health=healthMax;
    damage= d;
    speed = s;
    pos=p;
    findPath = true;
    goalT = go;
    gridP = new Point(int(pos.x),int(pos.y));
    gridT = new Point(goalT.X,goalT.Y);
    
    attackCooldown=.5;
    attackTimer=.5;
  }
  
  void update(){
    if(attackTimer>0){
     attackTimer-=DeltaTime; 
    }
    
    if (findPath == true) findPathAndSetNextStep();
    updateMove();
  }
  
  void draw(){
    stroke(20);
    strokeWeight(5);
    fill(230,30,30);
    ellipse(pos.x,pos.y,30,30);    
  }
  
  void attack(Tile target){
    attackTimer = attackCooldown;
    
    for(Tower t: towers){
     if(t.x == target.X && t.y==target.Y){
      //t.takedamage() //take damage currently does not deal a variable amount of damage 
      t.health -=damage;
     }
    }
    //might not be needed
    
  }
  
  void Die(){
    // ArrayList.remove(self);
    game.energy++;
  }
  
  void takeDamage(float d){
    health-=d;
    if(health<=0){
     Die(); 
    }
  }
  
  void findPathAndSetNextStep(){
    findPath = false;
    Tile start = game.level.getTile(gridP);
    Tile end = game.level.getTile(gridT);
    if (start == end) {
      path = null;
      return;
    }
    path = game.pathfinder.findPath(start, end);
    println(path.size());

    if (path != null && path.size() > 1) { 
      
      nextTile = path.get(1);
    }else{
      nextTile = start;
    }
    
  }//end void
  
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = game.level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pos);
    if(nextTile.isTower ||nextTile.TowerInTile||nextTile.isESpawner){
      if(attackTimer<=0){
        attack(nextTile);
        println("attack");
      }
    }else{
      pos.x += diff.x * .05;
      pos.y += diff.y * .05;
    }
    if (abs(diff.x) < snapThreshold) pos.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pos.y = pixlT.y;
    
    if (pixlT.x == pos.x && pixlT.y == pos.y){
      findPath = true;
    }
  }
  
}
