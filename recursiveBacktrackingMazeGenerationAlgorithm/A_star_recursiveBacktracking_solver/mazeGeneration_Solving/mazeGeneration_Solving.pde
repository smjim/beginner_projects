int cols, rows;
int scl = 20;

ArrayList<Cell> stack;

Cell[] cellGrid;

// Open and closed set
ArrayList<Spot> openSet = new ArrayList<Spot>();
ArrayList<Spot> closedSet = new ArrayList<Spot>();

// Start and end
Spot start;
Spot end;
Spot current;

// The road taken
ArrayList<Spot> path = new ArrayList<Spot>();
Spot[][] grid;


void setup() {
  size(800, 600);
  cols = (width/scl);
  rows = (height/scl);
  
  cellGrid = new Cell[cols * rows];
  grid = new Spot[cols][rows];
  stack = new ArrayList<Cell>();
  
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      cellGrid[i + j*cols] = new Cell(i, j); 
      grid[i][j] = new Spot(i, j);
    }
  }
  
  Cell current = cellGrid[0];
  
  do {  
    current.visited = true;
    
    Cell next = current.checkNeighbors();  
    if (next != current) {
      stack.add(current);
      
      removeWalls(current, next);
      current = next;
    } else if (stack.size() > 0) {
      current = stack.get(stack.size()-1);
      stack.remove(stack.size()-1);
    }
  } while (stack.size() != 0);
  
    
  // All the neighbors
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].addNeighbors(i, j);
    }
  }

  // Start and end
  start = grid[0][0];
  end = grid[cols - 1][rows - 1];

  // openSet starts with beginning only
  openSet.add(start);
}

void draw() {    
  // Am I still searching?
  if (openSet.size() > 0) {

    // Best next option
    int winner = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(winner).f) {
        winner = i;
      }
    }
    current = openSet.get(winner);
    
    // Did I finish?
    if (current == end) {
      noLoop();
      println("DONE!");
    }

    // Best option moves from openSet to closedSet
    //openSet = removeFromArray(openSet, current);
    openSet.remove(current);
    closedSet.add(current);

    // Check all the neighbors
    ArrayList<Spot> neighbors = current.neighbors;
    for (int i = 0; i < neighbors.size(); i++) {
      Spot neighbor = neighbors.get(i);

      // Valid next spot?
      if (!closedSet.contains(neighbor)) {
        float tempG = current.g + heuristic(neighbor, current);

        // Is this a better path than before?
        boolean newPath = false;
        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.g) {
            neighbor.g = tempG;
            newPath = true;
          }
        } else {
          neighbor.g = tempG;
          newPath = true;
          openSet.add(neighbor);
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

  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(255, 0, 0));
  }

  for (int i = 0; i < openSet.size(); i++) {
    openSet.get(i).show(color(0, 255, 0));
  }

  // Find the path by working backwards
  ArrayList<Spot> path = new ArrayList<Spot>();
  Spot temp = current;
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
  
  for (int i = 0; i < cellGrid.length; i++) {
    cellGrid[i].show();
  }
}
