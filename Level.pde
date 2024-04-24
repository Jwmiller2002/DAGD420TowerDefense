class Level {

  int[][] level;
  Tile[][] tiles;
  EnemySpawnTile [][] enemySpawnTile;
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
            PCGMAP.LEVEL1[Y][X] =20;
            if (randomPiece >8 && Y<7 && X<5 || randomPiece >8 && Y>28 && X<5 || randomPiece >8 && Y<7 && X>20 || randomPiece >8 && Y>28 && X>20) {
              setPiece =64; //ENEMY SPAWNER PLACEMENT
              PCGMAP.LEVEL1[Y][X] =64;
            }
            else if (randomPiece >6) {
              setPiece =2;
              //println(PCGMAP.LEVEL1[Y][X]);
              PCGMAP.LEVEL1[Y][X] =40;
              // println(PCGMAP.LEVEL1[Y][X]);
            } else if (randomPiece >3 && Y<26 && Y>7 && X<20 && X>5) {
              setPiece =70; //TOWERSPOT
              PCGMAP.LEVEL1[Y][X] =70;
            } else if (randomPiece >0) setPiece =1;
            PCGMAP.LEVEL1[Y][X] =1;
            layout[Y][X] = setPiece;
          }
          if (Y == 16 && X==13) {
            layout[Y][X] = 1000; //home base
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
