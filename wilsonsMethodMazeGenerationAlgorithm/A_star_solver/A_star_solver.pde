int scl = 10;
int cols, rows;

Cell[] grid;

//open and closed set but for pathfinding algorithm
ArrayList<Cell> searching = new ArrayList<Cell>();
ArrayList<Cell> searched = new ArrayList<Cell>();

//start and end
Cell start;
Cell end;
Cell current;

//path but for the pathfinding algorithm
ArrayList<Cell> route = new ArrayList<Cell>();

void setup() {
  size(800, 400);
  cols = width/scl;
  rows = height/scl;
  
  grid = new Cell[cols * rows];
  
  //cells not in the maze (open) and cells in the maze (closed)
  ArrayList<Cell> openSet = new ArrayList<Cell>();
  ArrayList<Cell> closedSet = new ArrayList<Cell>();
  
  //initialize the cells in grid
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i + j*width/scl] = new Cell(i, j);
      openSet.add(grid[i + j*cols]);
    }
  }
  
  //add an initial random cell to the maze
  int r = floor(random(cols * rows));
  closedSet.add(grid[r]);
  openSet.remove(grid[r]);  
  
  //create the paths and add them to the maze until the maze encompasses the entire grid
  while(openSet.size() > 0) {    
    //choose a random cell from openSet
    r = floor(random(openSet.size()));
    Cell temp = openSet.get(r);
    current = temp;
    
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
  
    while (temp.next != null) {
      if (!closedSet.contains(temp)) {
        path.add(temp);
        openSet.remove(temp);
        closedSet.add(temp);
        removeWalls(temp, temp.next);        
      }
      temp = temp.next;
    }
  }
  
  //show the status of the cells
  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(200));
  }
  
  for (int i = 0; i < grid.length; i++) {
    grid[i].show(color(255, 50));
  }
  
  
  
  //start and end of the pathfinding algorithm
  start = grid[0];
  end = grid[cols*rows-1];
  
  searching.add(start);
}

void draw() {    
  background(255);
  // Am I still searching?
  if (searching.size() > 0) {

    // Best next option
    int winner = 0;
    for (int i = 0; i < searching.size(); i++) {
      if (searching.get(i).f < searching.get(winner).f) {
        winner = i;
      }
    }
    current = searching.get(winner);
    
    // Did I finish?
    if (current == end) {
      noLoop();
      println("DONE!");
    }

    // Best option moves from searching to searched
    //searching = removeFromArray(searching, current);
    searching.remove(current);
    searched.add(current);

    // Check all the neighbors
    ArrayList<Cell> neighbors = testNeighbors(current);
    for (int i = 0; i < neighbors.size(); i++) {
      Cell neighbor = neighbors.get(i);

      // Valid next Cell?
      if (!searched.contains(neighbor)) {
        float tempG = current.g + heuristic(neighbor, current);

        // Is this a better path than before?
        boolean newPath = false;
        if (searching.contains(neighbor)) {
          if (tempG < neighbor.g) {
            neighbor.g = tempG;
            newPath = true;
          }
        } else {
          neighbor.g = tempG;
          newPath = true;
          searching.add(neighbor);
        }

        // Yes, it's a better path
        if (newPath) {
          neighbor.heuristic = heuristic(neighbor, end);
          neighbor.f = neighbor.g + neighbor.heuristic; //A*
          //neighbor.f = neighbor.g;                    //djikstra
          neighbor.previous = current;
        }
      }
    }
  } else {
    // Uh oh, no solution
    println("no solution");
    noLoop();
    return;
  }

  for (int i = 0; i < searched.size(); i++) {
    searched.get(i).show(color(255, 0, 0));
  }

  for (int i = 0; i < searching.size(); i++) {
    searching.get(i).show(color(0, 255, 0));
  }

  // Find the path by working backwards
  ArrayList<Cell> path = new ArrayList<Cell>();
  Cell temp = current;
  path.add(temp);
  while (temp.previous != null) {
    path.add(temp.previous);
    temp = temp.previous;
  }

  // Drawing path as continuous line
  noFill();
  stroke(255, 0, 200);
  strokeWeight(scl / 2);
  beginShape();
  for (int i = 0; i < path.size(); i++) {
    vertex(path.get(i).i * scl + scl / 2, path.get(i).j * scl + scl / 2);
  }
  endShape();
  
  for (int i = 0; i < grid.length; i++) {
    grid[i].show(color(200, 50));
  }
}
