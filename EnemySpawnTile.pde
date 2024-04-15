class EnemySpawnTile extends Tile{
  
  float disToGoal;
  float averageTowerDis;
  float rate;
  
  EnemySpawnTile(int x, int y){
    super(x,y);
  }
  
  void CheckBoard(){
    disToGoal= 50;
    averageTowerDis = 30;
    rate = disToGoal+200-averageTowerDis;
  }
  
  
  
  
  
  
}
