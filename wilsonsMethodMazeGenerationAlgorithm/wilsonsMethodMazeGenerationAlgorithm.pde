int scl = 10;
int cols, rows;

Cell[] grid;

//cells not in the maze (open) and cells in the maze (closed)
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

void setup() {
  //frameRate(1);
  size(400, 400);
  cols = width/scl;
  rows = height/scl;
  
  grid = new Cell[cols * rows];
  
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i + j*width/scl] = new Cell(i, j);
      //add the cell to the list of cells not in the maze
      openSet.add(grid[i + j*width/scl]);
    }
  }
  
  //add an initial random cell to the maze
  int r = floor(random(cols * rows));
  closedSet.add(grid[r]);
  openSet.remove(grid[r]);
}

void draw() {
  background(255);
  if (openSet.size() > 0) { 
    
    //choose a random cell from openSet
    int r = floor(random(openSet.size()));
    Cell temp = openSet.get(r);
    Cell current = temp;
  
  
    //start a path from initial until it reaches a cell in the maze
    while (!closedSet.contains(current)) { //while current is not part of the maze
      ArrayList<Cell> neighbors = findNeighbors(current);
      
      r = floor(random(neighbors.size()));
      Cell neighbor = neighbors.get(r);
      current.next = neighbor;
      current = neighbor;    
    }
    
    //find the path by working forwards
    ArrayList<Cell> path = new ArrayList<Cell>();

    while (temp.next != null) { //while temp.next != current
      if (!closedSet.contains(temp)) {
        path.add(temp);
        openSet.remove(temp);
        removeWalls(temp, temp.next);        
      }
      temp = temp.next;
    }
    
    for (int i = 0; i < path.size(); i++) {
      closedSet.add(path.get(i));
    }
  } else {
    println("done");
    noLoop();
  }
  
  //show the status of the cells
  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(200));
  }
  
  for (int i = 0; i < grid.length; i++) {
    grid[i].show(color(255, 0, 0, 50));
  }
}
