class EnemyManager{
  
  ArrayList<Enemy> enemies;
  ArrayList<EnemySpawnTile> SpawnTiles;
  float totalRate;
  float spawnTimer;
  float MaxSpawnTimer;
  float spawnLeft;
  
  EnemyManager(){
   enemies = new ArrayList<Enemy>();
   SpawnTiles = new ArrayList<EnemySpawnTile>();
   totalRate=0;
   spawnTimer=0;
   spawnLeft=0;
   MaxSpawnTimer=1;
   
  }
  
  
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
      enemies.remove(i);
      i--;
     }
    }
    
  }
  
  
  void SpawnEnemy(){
    
    totalRate=0;
    
    for(int i =0; i < SpawnTiles.size();i++){
      SpawnTiles.get(i).CheckBoard();
      totalRate+=SpawnTiles.get(i).rate;
    }
    
    for(int i = 0; i < SpawnTiles.size();i++){
      if(random(0,totalRate)<SpawnTiles.get(i).rate){
        Enemy e = new Enemy(50,5,7,new PVector(SpawnTiles.get(i).X,SpawnTiles.get(i).Y), game.level.tiles[6][6]);
        enemies.add(e);
        i = SpawnTiles.size()+1;
      }
      else{
        totalRate-=SpawnTiles.get(i).rate;
      }
    }//end for
    
  }//end function
  
}
