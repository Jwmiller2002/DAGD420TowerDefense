class Pathfinder{
  
  ArrayList<Tile> open = new ArrayList<Tile>();
  ArrayList<Tile> closed = new ArrayList<Tile>();
  
  Pathfinder(){
    open = new ArrayList<Tile>();
    closed = new ArrayList<Tile>();
  }
  
  ArrayList<Tile> findPath(Tile start, Tile end){
    
    open.clear();
    closed.clear();
    
    start.resetParent();
    // connect start to end
    connectStartToEnd(start, end);
    //build path back
    ArrayList<Tile> path = new ArrayList<Tile>();
    Tile pathNode = end;
    while(pathNode != null){
       path.add(pathNode);
       pathNode = pathNode.parent;
    }
    
    //step 3 revers the Arraylist.
      ArrayList<Tile> rev = new ArrayList<Tile>();
      int maxIndex = path.size()-1;
      for(int i = maxIndex;i>=0;i--){
       rev.add(path.get(i));
     }
    return rev;
  }
  
  void connectStartToEnd(Tile start, Tile end) {
    
    open.add(start);
    
    while(open.size()>0){
      // get node in open with lowest f value
      float F = 999999;
      int index = -1;
      
      for(int i=0; i<open.size();i++){
        Tile temp = open.get(i);
        if(temp.F<F){
          F = temp.F;
          index = i;
        }
      }
      
      Tile current = open.remove(index);
      closed.add(current);
      
      if(current == end){
        // path found 
        break;
      }
      
      //Loop through all of current's neighbors
      for(int i =0; i<current.neighbors.size(); i++){
        Tile neighbor = current.neighbors.get(i);
        if(!tileInArray(closed, neighbor)){
          if(!tileInArray(open, neighbor)){
            open.add(neighbor);
            neighbor.setParent(current);
            neighbor.doHeuristic(end, false);
          }else{
           if(neighbor.G > current.G + neighbor.getTerrainCost()){
              neighbor.setParent(current);
              neighbor.doHeuristic(end, false);
            } //if
          }//else
        }//if in closed
      }//end for loop
      
    }//end whileLoop
    
  }//end method
  
  boolean tileInArray(ArrayList<Tile> a, Tile t) {
    for (int i = 0; i < a.size (); i++) {
      if (a.get(i) == t) return true;
    }
    return false;
  }
  
  
}//end class
