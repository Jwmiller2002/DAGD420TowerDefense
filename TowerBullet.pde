class TowerBullet{
  private float x,y;
  public boolean isDead;
  private float towerType;
  public ArrayList<Enemy> enemies;
  private float targetEnemy;
  
  
 TowerBullet(float towerType,float towerX, float towerY, float enemyNum){
   this.x=towerX;
   this.y=towerY;
   targetEnemy = enemyNum;
   this.towerType = towerType;
 }
 void draw(){
  if(towerType ==0){//Basic Tower
    ellipse(x,y,10,10);
    hitEnemy();
  }
  else if(towerType ==1){//Support Tower
    
  }
  else if(towerType ==2){// Oil/slow enemy tower
    
  }
  else if(towerType ==3){// electric/aoe tower
    
  }
  else if(towerType ==4){//Repair tower,  Limited Lifetime?
    
  }
 }
  public void hitEnemy(){
    
  }
}
