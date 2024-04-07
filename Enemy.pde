class Enemy{
  
  float health;
  float healthMax;
  float damage;
  float speed;
  PVector pos;
  ArrayList<Tile> path; 
  Tile goalT;
  Tile nextTile;
  boolean findPath = false;

  
  Enemy(float h,float d, float s, PVector p){
    healthMax=h;
    health=healthMax;
    damage= d;
    speed = s;
    pos=p;
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
    Tile start = level.getTile(pos);
    Tile end = level.getTile(goalT);
    if (start == end) {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) { 
      nextTile = path.get(1);
    }
    
  }//end void
  
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = level.getTileCenterAt(pos);
    PVector diff = PVector.sub(pixlT, pos);
    if(nextTile.type == goal||nextTile.type == tower){
     //attack thing 
      
    }else{
      pos.x += diff.x * .2;
      pos.y += diff.y * .2;
    }
    if (abs(diff.x) < snapThreshold) pos.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pos.y = pixlT.y;

    if (pixlT.x == pos.x && pixlT.y == pos.y) findPath = true;
  }
  
}
