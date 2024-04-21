class EnemyAcid extends Enemy{
  
  float acidTimer;
  float acidDamage;
  float acidRadius;
  
  EnemyAcid(float h,float d, float s, PVector p, Tile go){
    super(h,d,s,p,go);
    acidTimer=.2;
    acidDamage=1;
    acidRadius=50;
  }
  
  void update(){
   super.update(); 
   if(acidTimer>0){
    acidTimer-=DeltaTime; 
   }else{
    acidTimer=.2;
    for(Tower t: towers){
     float xdif = t.x-pos.x;
     float ydif = t.y-pos.y;
     if(sqrt(xdif*xdif+ydif*ydif)<acidRadius){
       t.health -=1;
     }
    }
   }//end else if
    
  }//end update
  
}
