static class PCGMAP {
  
  // MOVEMENT COST (CORRESPONDS TO THE TERRAIN TYPE IN THE LEVELS)
  // For example terrain 0 has a movecost of 1,
  // and terrain 1 has a movecost of 4
  static int[] MOVECOST = {1, 4,5,6,7,8, 1000};
  
  
  static int[][] LEVEL1 = 
  {
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4},
    {0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0},
    {4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0},
    {0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0}
  };
  
}
