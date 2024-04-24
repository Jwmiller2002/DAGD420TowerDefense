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
  float jankCoolDown =1;
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
    findPath = false;
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
    
    findPathAndSetNextStep();
    updateMove();
  }
  
  void draw(){
    stroke(20);
    strokeWeight(5);
    fill(230,30,30);
    ellipse(pos.x,pos.y,30,30);  
    drawPath();
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
  void drawPath() {
    if (path != null && path.size() > 1) {
      stroke(0);
      PVector prevP = pos.get();
      for (int i = 1; i < path.size (); i++) {
        PVector currP = path.get(i).getCenter();
        line(prevP.x, prevP.y, currP.x, currP.y);
        prevP = currP;
      }
      noStroke();
      ellipse(prevP.x, prevP.y, 8, 8);
    }
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

    if (path != null && path.size() > 1) { 
      nextTile = path.get(1);
      if(jankCoolDown <=.3){
        if(nextTile.isPassable()) gridP = new Point(nextTile.X, nextTile.Y);
        jankCoolDown =0.5;
      }
      else jankCoolDown -=1*DeltaTime;
    }
    
  }//end void
  
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = game.level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pos);
    if(nextTile.isTower){
      if(attackTimer<=0){
        attack(nextTile);
      }
    }else{
      pos.x += diff.x * 1;
      pos.y += diff.y * 1;
    }
    if (abs(diff.x) < snapThreshold) pos.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pos.y = pixlT.y;

    if (pixlT.x == pos.x && pixlT.y == pos.y) findPath = true;
  }
  
}
