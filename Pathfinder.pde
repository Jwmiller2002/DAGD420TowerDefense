class Pathfinder {

  boolean useManhattan = false;
  boolean useDiagonals = false;
  ArrayList<Tile> open = new ArrayList<Tile>(); // collection of tiles we can use to solve the algorithm
  ArrayList<Tile> closed = new ArrayList<Tile>(); // collection of tiles that we've ruled out as NOT part of the solution

  Pathfinder() {
  }

  ArrayList<Tile> findPath(Tile start, Tile end) {

    // TODO: make the pathfinding algorithm ;)
    open.clear();
    closed.clear();

    start.resetParent();
    //1. Connect Start to End
    connectStartToEnd(start, end);
    //2. Build a path back to beginning
    ArrayList<Tile> path = new ArrayList<Tile>();
    Tile pathNode = end;
    while (pathNode != null ) {
      path.add(pathNode);
      pathNode = pathNode.parent;
    }
    //3.  Reverse the Collection
    ArrayList<Tile> rev = new ArrayList<Tile>();
    int maxIndex = path.size() - 1;
    for (int i = maxIndex; i >= 0; i--) {
      rev.add(path.get(i));
    }

    return rev;
  }
  /**
   * This method is simply for debugging. It prints out a path to the console.
   * @param ArrayList<Tile> path  The path to print out.
   */
  void outputPath(ArrayList<Tile> path) {
    //println("BEST PATH:");
    int i = 0;
    for (Tile t : path) {
      print("\t" + i + ": " + t.X + ", " + t.Y);
      if (i == 0) print(" (current location)");
      println(); 
      i++;
    }
  }
  void connectStartToEnd(Tile start, Tile end) {

    // TODO: Make the algorithm
    open.add(start);
    while (open.size() > 0) {
      //Get the node open with the lowest F value
      float F = 99999999;
      int index = -1;
      for (int i = 0; i < open.size(); i++) {
        Tile temp = open.get(i);
        if (temp.F < F) {
          F = temp.F;
          index = i;
        }
      }
      Tile current = open.remove(index);
      closed.add(current);
      if (current == end) {
        break;
      }
      //Loop through all of current's niehgbors
      for (int i = 0; i < current.neighbors.size(); i++) {
        Tile neighbor = current.neighbors.get(i);
        if (!tileInArray(closed, neighbor)) {
          if (!tileInArray(open, neighbor)) {
            open.add(neighbor);
            neighbor.setParent(current);
            neighbor.doHeuristic(end, useManhattan);
          } else {
            if (neighbor.G > current.G + neighbor.getTerrainCost()) {
              neighbor.setParent(current);
              neighbor.doHeuristic(end, useManhattan);
            }
          }
        }
      }
    }
  } // end method
  /**
   * This method returns true if a particular tile is already in an ArrayList.
   * @param ArrayList<Tile> a  The haystack to search in.
   * @param Tile t  The needle to search for.
   * @return boolean  Whether or not the needle is in the haystack.
   */
  boolean tileInArray(ArrayList<Tile> a, Tile t) {
    for (int i = 0; i < a.size (); i++) {
      if (a.get(i) == t) return true;
    }
    return false;
  }
  /*
   * Changes the heuristic.
   */
  void toggleHeuristic() {
    useManhattan = !useManhattan;
  }
}
