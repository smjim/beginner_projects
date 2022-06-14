class Cell {
  int i, j;
  
  //walls
  boolean top;
  boolean right;
  boolean bottom;
  boolean left;
  
  //the cell stores its child cell to find the path
  Cell next = null;
      
  Cell(int i_, int j_) {
    i = i_;
    j = j_;
    
    top = true;
    right = true;
    bottom = true;
    left = true;
  }
  
  void show(color c) {
    fill(c);
    noStroke();
    rect(i*scl, j*scl, scl, scl);
    
    stroke(0);
    if (top == true)    {line((i)*scl, (j)*scl,(i+1)*scl, (j)*scl);}     //top
    if (right == true)  {line((i+1)*scl, (j)*scl,(i+1)*scl, (j+1)*scl);} //right
    if (bottom == true) {line((i)*scl, (j+1)*scl,(i+1)*scl, (j+1)*scl);} //bottom
    if (left == true)   {line((i)*scl, (j)*scl,(i)*scl, (j+1)*scl);}     //left
  }
}

ArrayList<Cell> findNeighbors(Cell current) {
  ArrayList<Cell> neighbors = new ArrayList<Cell>();
  if (current.j>0)      {neighbors.add(grid[(current.i) + (current.j-1)*cols]);} //top
  if (current.i<cols-1) {neighbors.add(grid[(current.i+1) + (current.j)*cols]);} //right
  if (current.j<rows-1) {neighbors.add(grid[(current.i) + (current.j+1)*cols]);} //bottom
  if (current.i>0)      {neighbors.add(grid[(current.i-1) + (current.j)*cols]);} //left   
  return neighbors;
}

void removeWalls(Cell a, Cell b) {
  int x = a.i - b.i;
  int y = a.j - b.j;
  
  if (x == 1) {
    a.left = false;
    b.right = false;
  } else if (x == -1) {
    a.right = false;
    b.left = false;
  }
  if (y == 1) {
    a.top = false;
    b.bottom = false;
  } else if (y == -1) {
    a.bottom = false;
    b.top = false;
  }
}
