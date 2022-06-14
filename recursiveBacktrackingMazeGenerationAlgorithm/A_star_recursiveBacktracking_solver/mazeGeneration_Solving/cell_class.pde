class Cell {
  int i, j;
  boolean visited;
  boolean top, right, bottom, left;
  
  Cell(int x, int y) {
    i = x;
    j = y;
    top = true;
    right = true;
    bottom = true;
    left = true;
    visited = false;
  }
  
  void highlight() {
    int x = i*scl;
    int y = j*scl;
    noStroke();
    fill(0, 255, 0, 50);
    rect(x, y, scl, scl);
  }
  
  Cell checkNeighbors() {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
    if (index(i, j-1) != -1) {
      Cell top = cellGrid[index(i, j-1)]; 
      if (top.visited == false) {
        neighbors.add(top);
      }
    }
    if (index(i+1, j) != -1) {
      Cell right = cellGrid[index(i+1, j)];
      if (right.visited == false) {
        neighbors.add(right);
      }
    }  
    if (index(i, j+1) != -1) {
      Cell bottom = cellGrid[index(i, j+1)];
      if (bottom.visited == false) {
        neighbors.add(bottom);
      }
    }
    if (index(i-1, j) != -1) {
      Cell left = cellGrid[index(i-1, j)];    
      if (left.visited == false) {
        neighbors.add(left);
      }
    }
    
    if (neighbors.size() > 0) {
      int r = floor(random(neighbors.size()));
      return neighbors.get(r);
    } else {
      return cellGrid[index(i, j)];
    }
  }
  
  void show() {
    int x = i*scl;
    int y = j*scl;
    
    stroke(0);
    if (top == true)    {line(x,     y,     x+scl, y);}
    if (right == true)  {line(x+scl, y,     x+scl, y+scl);}
    if (bottom == true) {line(x,     y+scl, x+scl, y+scl);}
    if (left == true)   {line(x,     y,     x,     y+scl);}
    
    if (visited == true) {
      fill(0, 255, 255, 100);
      noStroke();
      rect(x, y, scl, scl);
    }
  }
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

int index(int i, int j) {
  if (i < 0 || j < 0 || i > cols-1 || j > rows-1) {
    return -1;
  }
  return i + j*width/scl;
}
