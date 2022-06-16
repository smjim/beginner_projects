class Cell {
  int i, j;
  boolean top, right, bottom, left;
  ArrayList<Cell> neighbors;
  FloatList weights = new FloatList();
  
  Cell(int _i, int _j) {
    i = _i;
    j = _j;
    
    top = true;
    right = true;
    bottom = true;
    left = true;
  }
  
  void checkNeighbors() {
    //lower weight means higher priority of being picked
    //biases; max 100
    float biasV = 1; //vertical bias; makes the maze have more vertical edges
    float biasH = 1; //horizontal bias; makes the maze have more horizontal edges
    
    this.neighbors = new ArrayList<Cell>();
    this.weights.clear();
    if (index(i, j-1) != -1) {
      Cell top = grid[index(i, j-1)]; 
      neighbors.add(top);
      
      // dot product of movement vector with difference between mouse position and neighbor position
      float weight = map(mouseY - j*scl, -height, height, 0, 100);
      // favors neighbors that are already closer to the mouse
      weight += sqrt(pow(mouseY - (j-1)*scl, 2) + pow(mouseX - (i)*scl, 2));
      // add in some randomness
      weight -= random(biasV);
      this.weights.append(weight);
    }
    if (index(i+1, j) != -1) {
      Cell right = grid[index(i+1, j)];
      neighbors.add(right);
      float weight = map(mouseX - i*scl, -width, width, 100, 0);
      weight += sqrt(pow(mouseY - (j)*scl, 2) + pow(mouseX - (i+1)*scl, 2));
      weight -= random(biasH);
      this.weights.append(weight);
    }  
    if (index(i, j+1) != -1) {
      Cell bottom = grid[index(i, j+1)];
      neighbors.add(bottom);
      float weight = map(j*scl - mouseY, -height, height, 0, 100);
      weight += sqrt(pow(mouseY - (j+1)*scl, 2) + pow(mouseX - (i)*scl, 2));
      weight -= random(biasV);
      this.weights.append(weight);
    }
    if (index(i-1, j) != -1) {
      Cell left = grid[index(i-1, j)];    
      neighbors.add(left);
      float weight = map(i*scl - mouseX, -width, width, 100, 0);
      weight += sqrt(pow(mouseY - (j)*scl, 2) + pow(mouseX - (i-1)*scl, 2));
      weight -= random(biasH);
      this.weights.append(weight);
    }   
  }
  
  void show(color c) {
    int x = i*scl;
    int y = j*scl;
    
    fill(c);
    noStroke();
    rect(x, y, scl, scl);
    
    stroke(0);
    if (top == true)    {line(x,     y,     x+scl, y    );}
    if (right == true)  {line(x+scl, y,     x+scl, y+scl);}
    if (bottom == true) {line(x,     y+scl, x+scl, y+scl);}
    if (left == true)   {line(x,     y,     x,     y+scl);}
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
