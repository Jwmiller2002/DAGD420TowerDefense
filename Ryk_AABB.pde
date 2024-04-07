class AABB{
  float x, y, w, h; //w is width, h is height
  float vx, vy;
  
  AABB(float x, float y, float w, float h, float vx, float vy){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vx = vx;
    this.vy = vy;
  }
  
  void draw(){
    //fill(0);
    rect(x, y, w, h);
    update();
  }
  
  void update(){
    x += vx;
    y += vy;
  }
}
