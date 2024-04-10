
Title title;
Options options;
Help help;
Game game;
End end; //Game Over 

boolean prevMouse;

ArrayList<Tower> towers;

void setup(){
  //fullScreen();
  init();
  size(1080, 1080);
  TileHelper.app = this;
  
  towers = new ArrayList<Tower>();
}

void init(){
  //Switch this code to choose the scene that first appears when booting the program up
  switchToTitle();
}

void draw(){
  for(int i=0;i<towers.size()-1;i++){
    Tower t = towers.get(i);
    t.draw();
    if(t.isDead) towers.remove(i);
  }
  /* This is the Scene manager code. 
   * It checks the update to see if any scenes switching should happen.
   * Then it draws the scene
   */
  
  if(title != null){
    title.update();
    if(title != null){
      title.draw();
    }
  }
  else if(options != null){
    options.update();
    if(options != null){
      options.draw();
    }
  }
  else if(help != null){
    help.update();
    if(help != null){
      help.draw();
    }
  }
  else if(game != null){
    game.update();
    if(game != null){
      game.draw();
    }
  }
  else if(end != null){
    end.update();
    if(end != null){
      end.draw();
    }
  }
  
}

void switchToTitle(){
  title = new Title();
  options = null;
  help = null;
  game = null;
  end = null;
}

void switchToOptions(){
  title = null;
  options = new Options();
  help = null;
  game = null;
  end = null;
}

void switchToHelp(){
  title = null;
  options = null;
  help = new Help();
  game = null;
  end = null;
}

void closeApp(){
  exit();
}

void switchToGame(){
  title = null;
  options = null;
  help = null;
  game = new Game();
  end = null;
}

void switchToEnd(){
  title = null;
  options = null;
  help = null;
  game = null;
  end = new End();
}

/*  

This is the player class and the functions it uses for pathfindingl, This can be used as starting point for the enemy class movements and referencing


class Player {

  // GRID-SPACE COORDINATES:
  Point gridP = new Point(); // current position
  Point gridT = new Point(); // target position (pathfinding goal)

  // PIXEL-SPACE COORDINATES:
  PVector pixlP = new PVector(); // current pixel position

  ArrayList<Tile> path;    // the path to follow to get to the target position
  boolean findPath = false;

  Player() {
    teleportTo(gridP);
  }
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixlP = tile.getCenter();
    }
  }
  void setTargetPosition(Point gridT) {
    this.gridT = gridT.get();
    findPath = true;
  }
  void update() {
    if (findPath == true) findPathAndTakeNextStep();
    updateMove();
  }
  void findPathAndTakeNextStep() {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if (start == end) {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) { 
      Tile tile = path.get(1);
      if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
    }
  }
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pixlP);
    
    pixlP.x += diff.x * .2;
    pixlP.y += diff.y * .2;
    
    if (abs(diff.x) < snapThreshold) pixlP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixlP.y = pixlT.y;

    if (pixlT.x == pixlP.x && pixlT.y == pixlP.y) findPath = true;
  }
  void draw() {
    noStroke();
    fill(0);
    ellipse(pixlP.x, pixlP.y, 28, 28);
    drawPath();
  }
  void drawPath() {
    if (path != null && path.size() > 1) {
      stroke(0);
      PVector prevP = pixlP.get();
      for (int i = 1; i < path.size (); i++) {
        PVector currP = path.get(i).getCenter();
        line(prevP.x, prevP.y, currP.x, currP.y);
        prevP = currP;
      }
      noStroke();
      ellipse(prevP.x, prevP.y, 8, 8);
    }
  }
} */
