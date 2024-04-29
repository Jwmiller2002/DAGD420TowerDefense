class EnemyFlying extends Enemy{
  
  
  EnemyFlying(float h,float d, float s, PVector p, Tile go){
    super(h,d,s,p,go);
    
  }
  
  void update(){
    if(attackTimer>0){
     attackTimer-=DeltaTime; 
    }
    
    findPathAndSetNextStep();
    updateMove();
  }
  
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = new PVector(goalT.X,goalT.Y);
    PVector diff = PVector.sub(pixlT, pos);
    
    if (abs(diff.x) < snapThreshold) pos.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pos.y = pixlT.y;

    if (pixlT.x == pos.x && pixlT.y == pos.y) findPath = true;
  }
  
  void draw(){
    stroke(20);
    strokeWeight(5);
    fill(150,150,240);
    ellipse(pos.x,pos.y,30,30);
    drawPath();
  }
  
}
