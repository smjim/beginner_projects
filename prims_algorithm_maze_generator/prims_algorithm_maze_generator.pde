int cols, rows;
int scl = 20;

Cell[] grid;
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

ArrayList<Edge> path = new ArrayList<Edge>();

void setup() {
  size(800, 600);
  cols = width/scl;
  rows = height/scl;
  
  grid = new Cell[cols*rows];
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[index(i, j)] = new Cell(i, j);
      openSet.add(grid[index(i, j)]);
    }
  }
  for (int i = 0; i < grid.length; i++) {
    grid[i].checkNeighbors();
  }
  
  Cell initial = grid[index(0, 0)];
  openSet.remove(initial);
  closedSet.add(initial);
}

void draw() {
  
  if (openSet.size() > 0) {
    float minWeight = 100;
    Cell current = null;
    Cell next = null;
    Edge nextLine = null;
    
    for (int i = 0; i < closedSet.size(); i++) {
      Cell c = closedSet.get(i);
      
      for (int j = 0; j < c.neighbors.size(); j++) {
        Cell temp = c.neighbors.get(j);
        Edge line = new Edge(c.i, c.j, temp.i, temp.j);
        float tempWeight = c.weights.get(j);
        
        if (tempWeight < minWeight && !closedSet.contains(temp)) {
          minWeight = tempWeight;
          next = temp;
          current = c;
          nextLine = line;
        }
      }
    }
    
    removeWalls(current, next);
    openSet.remove(next);
    closedSet.add(next);        
    path.add(nextLine);    
  } else {
    
    println("done");
    noLoop();
  }
  
  ////box style
  //for (Cell c : grid) {
  //  if (closedSet.contains(c)) {
  //    c.show(color(0, 255, 255));
  //  } else if (openSet.contains(c)) {
  //    c.show(color(255));
  //  }
  //}

  //line style
  background(255);
  translate(scl/2, scl/2);
  for (int i = 0; i < grid.length; i++) {
    stroke(0);
    strokeWeight(scl/4);
    point(grid[i].i*scl, grid[i].j*scl);
  }
  for (int i = 0; i < path.size(); i++) {
    Edge line = path.get(i);
    stroke(255, 0, 0);
    strokeWeight(scl/8);
    line(line.x1, line.y1, line.x2, line.y2);
  }
}
