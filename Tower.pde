class Tower{
  private float health;
  private float towerType;
  private float x,y =500;
  private float ramCost;
  private float energyCost;
 Tower(float pointOnGrid){
   x= mouseX;
   y = mouseY;
 }
 void draw(){
   fill(200,20,130);
   rect(x,y,20,20);
 }
  
}
