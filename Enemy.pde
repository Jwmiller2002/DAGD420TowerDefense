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
  
  Point gridP = new Point(); // current position
  Point gridT = new Point();

  
  Enemy(float h,float d, float s, PVector p){
    healthMax=h;
    health=healthMax;
    damage= d;
    speed = s;
    pos=p;
    findPath = false;
    gridP = new Point();
    gridT = new Point();
  }
  
  void update(){
    findPathAndSetNextStep();
    updateMove();
  }
  
  void draw(){
    noStroke();
    fill(230,30,30);
    ellipse(pos.x,pos.y,30,30);    
  }
  
  void attack(){
    //might not be needed
  }
  
  void Die(){
    // ArrayList.remove(self);
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
    }
    
  }//end void
  
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = game.level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pos);
    //if(nextTile.type == goal||nextTile.type == tower){
    //attack thing 
      
   // }else{
      pos.x += diff.x * .2;
      pos.y += diff.y * .2;
    //}
    if (abs(diff.x) < snapThreshold) pos.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pos.y = pixlT.y;

    if (pixlT.x == pos.x && pixlT.y == pos.y) findPath = true;
  }
  
}
