class Level {

  int[][] level;
  Tile[][] tiles;
  boolean useDiagonals = false;
  private boolean randomizeOnce =true;

  Level() {
    loadLevel(PCGMAP.LEVEL1);
  }
  void draw() {
    noStroke();
    //if(TileHelper.isHex) rectMode(CENTER);
    for (int Y = 0; Y < tiles.length; Y++) {
      for (int X = 0; X < tiles[Y].length; X++) {
        tiles[Y][X].draw();
      }
    }
    fill(0);
  }
  Tile getTile(int X, int Y) {
    if (X < 0 || Y < 0) return null;
    if (Y >= tiles.length || X >= tiles[0].length) return null;
    return tiles[Y][X];
  }
  Tile getTile(Point p) {
    return getTile(p.x, p.y);
  }
  PVector getTileCenterAt(Point p) {
    Tile tile = getTile(p);
    if (tile == null) return new PVector();
    return tile.getCenter();
  }
  boolean isPassable(Point p) {
    Tile tile = getTile(p);
    if (tile == null) return false;
    return tile.isPassable();
  }

  void reloadLevel() {
    loadLevel(level);
  }

  void loadLevel(int[][] layout) {

    level = layout; // cache the layout (to enable reloading levels)


    //TODO: Build the level from the level data.
    //1. Build a 2D tiles array to hold all of the tiles.
    int  ROWS = layout.length;
    int COL = layout[0].length;
    tiles = new Tile[ROWS][COL];

    if (randomizeOnce) {                    //RANDOMIZER
      for (int Y = 0; Y < ROWS; Y++) {
        for (int X = 0; X < COL; X++) {
          if (Y != 16 && X!=13) {
            float randomPiece = random(0, 9);
            int setPiece =0;
            if (randomPiece >7) setPiece =2;
            else if (randomPiece >4) setPiece =1;
            else if (randomPiece >0) setPiece =0;

            level[Y][X] = setPiece;
          }
          if (Y == 16 && X==13) {
            level[Y][X] = 1000; //home base
          }
        }
      }
      randomizeOnce =false;
    }

    //2. Instantiate all tiles, add to the tiles array.
    for (int Y = 0; Y < ROWS; Y++) {
      for (int X = 0; X < COL; X++) {
        Tile tile = new Tile(X, Y);
        tile.TERRAIN = layout[Y][X];
        tiles[Y][X] = tile;
      }
    }
    //3. Add all neighbors to each tile. (this varies with grid type: square / type; AND this varies with whether or not we allow diagonal movement)
    for (int Y = 0; Y < ROWS; Y++) {
      for (int X = 0; X < COL; X++) {

        //SQUARE MOVEMENT
        tiles[Y][X].addNeighbors(new Tile[] {
          getTile(X-1, Y),
          getTile(X+1, Y),
          getTile(X, Y-1),
          getTile(X, Y+1)
          });
        if (useDiagonals) {
          tiles[Y][X].addNeighbors(new Tile[] {
            getTile(X-1, Y-1),
            getTile(X+1, Y+1),
            getTile(X+1, Y-1),
            getTile(X-1, Y+1)
            });
        }
      }
    }
  } // end loadLevel()

  void toggleDiagonals() {
    useDiagonals = !useDiagonals;
  }
}
