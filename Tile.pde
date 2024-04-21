static class TileHelper {
Pathfinder pathfinder;
Level level;
  static DAGD420TowerDefense app;
  
  final static int W = 32;
  final static int H = 32;
  final static int halfW = W / 2;
  final static int halfH = H / 2;
  
  public boolean isESpawner =false;

  static PVector gridToPixel(Point p) {
    return gridToPixel(p.x, p.y);
  }
  static PVector gridToPixel(int X, int Y) {
    PVector v = new PVector(X * W, Y * H);
    
    return v;
  }
  static Point pixelToGrid(PVector v) {

    int x = (int)(v.x / W);

    int y = (int)(v.y / H);

    return app.new Point(x, y);
  }
}

class Tile {

  int X; // GRID X
  int Y; // GRID Y
  int TERRAIN = 0; // TERRAIN TYPE
  boolean hover = false;
  
  TileProperty property;
  
  boolean isESpawner=false;
  boolean isTower =false;
  public boolean TowerInTile =false;

  Tile(int X, int Y) {
    this.X = X;
    this.Y = Y;
    
    property = new TileProperty(X, Y);
  }
  // DRAW THIS TILE:
  void draw() {
    if (TERRAIN == 1000) fill(73);
    if (TERRAIN == 0) { //Main Path

      if (hover) {
      } else return; // don't draw empty tiles
    }

    /*if (TERRAIN == 1) fill(200);
    *if (TERRAIN == 2) fill(255);
    *if (hover) fill(255, 255, 0);
    */
    if(TERRAIN == 1){
      property.setProperty(10);
    }

    if (TERRAIN == 1) fill(50,205,50);
    if (TERRAIN == 2) fill(88,59,39);
    if(TERRAIN ==4) fill(33);
    if(TERRAIN == 64){
      fill(200,0,0);
      isESpawner =true;
    }
    if(TERRAIN == 70){ //TOWER SPOT
      fill(0,255,0);
      isTower =true;
    }
    if(TERRAIN == 71){//BASICTOWER
      fill(0,200,0);
      isTower =true;
      
       println("TOWER1");
    }
    if(TERRAIN == 72){//RAM TOWER
      fill(10,200,0);
      isTower =true;
      println("TOWER2");
    }
    if(TERRAIN == 73){//Wall
      fill(0,255,30);
      isTower =true;
       println("TOWER3");
    }
    if(TERRAIN == 74){//POWER
      fill(10,255,10);
      isTower =true;
       println("TOWER3");
    }
    if (hover) fill(255, 255, 0);
    
    PVector p = TileHelper.gridToPixel(X, Y);
    rect(p.x, p.y, TileHelper.W, TileHelper.H);

    hover = false;
  }
  // GET THE CENTER POINT OF THIS TILE IN PIXEL-SPACE:
  PVector getCenter() {
    PVector p = TileHelper.gridToPixel(new Point(X, Y));
    p.x += TileHelper.halfW;
    p.y += TileHelper.halfH;
    return p;
  }
  boolean isPassable() {
    return (TERRAIN != 1000);
  }

  ///////////////////////////////////////////////////
  /////////////// PATHFINDING STUFF: ////////////////
  ///////////////////////////////////////////////////

  ArrayList<Tile> neighbors = new ArrayList<Tile>(); // LIST OF NEIGHBORING TILES
  Tile parent; // PARENT TILE (previous tile in the path)
  float G; // COST TO TRAVEL TO THIS TILE... from origin!
  float F; // TOTAL COST OF THIS TILE

  // ADD THE SUPPLIED TILES TO THIS TILE'S LIST OF NEIGHBORS:
  void addNeighbors(Tile[] tiles) {
    for (Tile t : tiles) {
      if (t != null) neighbors.add(t);
    }
  }
  // SET THE PARENT OF THIS TILE:
  // This is used during pathfinding to remember where the path originated.
  void setParent(Tile n) {
    parent = n;
    G = parent.G + getTerrainCost();
  }
  // RESET THE PARENT OF THIS TILE:
  // This is used when starting pathfinding. When reversing back
  // through the path, we know we've arrived once we reach a tile
  // without a parent tile.
  void resetParent() {
    parent = null;
    G = 0;
    F = 0;
  }
  // RETURN THE COST OF MOVING INTO THIS TILE:
  float getTerrainCost() {
    if (TERRAIN >= 0 && TERRAIN < PCGMAP.MOVECOST.length) return PCGMAP.MOVECOST[TERRAIN];
    return 0;
  }
  // HEURISTICS CALULATIONS:
  void doHeuristic(Tile n, boolean useManhattan) {
    if (useManhattan) F = G + distanceManhattan(n);
    if (!useManhattan) F = G + distanceEuclidean(n);
  }
  // MANHATTAN HEURISTIC CALCULATION:
  float distanceManhattan(Tile n) {
    return abs(n.X - X) + abs(n.Y - Y);
  }
  // EUCLIDEAN HEURISTIC CALCULATION:
  float distanceEuclidean(Tile n) {
    float dx = n.X - X;
    float dy = n.Y - Y;
    return sqrt(dx * dx + dy * dy);
  }
}
