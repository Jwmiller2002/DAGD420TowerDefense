class EnemyManager{
  
  ArrayList<Enemy> enemies;
  ArrayList<Tile> SpawnTiles;
  float totalRate;
  float spawnTimer;
  float MaxSpawnTimer;
  float spawnLeft;
  
  EnemyManager(){                           //isESpawner is the variable you need
   enemies = new ArrayList<Enemy>();
   SpawnTiles = new ArrayList<Tile>();
   totalRate=0;
   spawnTimer=1;
   spawnLeft=0;
   MaxSpawnTimer=1;
   for (int Y = 0; Y < game.level.tiles.length; Y++) {
      for (int X = 0; X < game.level.tiles[Y].length; X++) {
        if(game.level.tiles[Y][X].isESpawner){
          SpawnTiles.add(game.level.tiles[Y][X]);
        }
      }
    }
   println(SpawnTiles.size());
  }//end constructor
  
  
  void update(){
    if(spawnTimer>0){
       spawnTimer -=  DeltaTime;
    }
    if(spawnTimer<=0&&spawnLeft>0){
      SpawnEnemy();
      spawnLeft--;
      spawnTimer = MaxSpawnTimer;
    }
    for(int i=0; i < enemies.size();i++){
     enemies.get(i).update();
     if(enemies.get(i).health <=0){
       enemies.get(i).Die();
      enemies.remove(i);
      i--;
     }
    }
    
  }
  
  void draw(){
    for(int i=0; i < enemies.size();i++){
     enemies.get(i).update();
    }
  }
  
  
  void SpawnEnemy(){
    
    totalRate=0;
    
    for(int i =0; i < SpawnTiles.size();i++){
      totalRate+=CalcRate(SpawnTiles.get(i));
    }
    
    for(int i = 0; i < SpawnTiles.size();i++){
      if(random(0,totalRate)<CalcRate(SpawnTiles.get(i))){
        float rad = random(0,100);
        Enemy e = new Enemy(50,5,7,new PVector(SpawnTiles.get(i).X,SpawnTiles.get(i).Y), game.level.tiles[6][6]);
        if(rad>75){
          e = new EnemyAcid(50,5,7,new PVector(SpawnTiles.get(i).X,SpawnTiles.get(i).Y), game.level.tiles[6][6]);
        }else if(rad>50){
          e = new EnemyFlying(50,5,7,new PVector(SpawnTiles.get(i).X,SpawnTiles.get(i).Y), game.level.tiles[6][6]);
        }else if(rad>25){
          e = new EnemySlow(50,5,7,new PVector(SpawnTiles.get(i).X,SpawnTiles.get(i).Y), game.level.tiles[6][6]);
        }else{
         // basic enemy
        }
        enemies.add(e);
        i = SpawnTiles.size()+1;
      }
      else{
        totalRate-=CalcRate(SpawnTiles.get(i));
      }
    }//end for
    
  }//end function
  
  float CalcRate(Tile t){
   int disX = t.X-game.level.tiles[6][6].X;
   int disY = t.Y-game.level.tiles[6][6].Y;
    return sqrt(disX*disX+disY*disY);
  }//end function
  
}
