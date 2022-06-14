int cols, rows;
int scl = 20;

ArrayList<Cell> stack;

Cell[] grid;
Cell current;

void setup() {
  size(800, 600);
  cols = (width/scl);
  rows = (height/scl);
  
  grid = new Cell[cols * rows];
  stack = new ArrayList<Cell>();
  
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i + j*cols] = new Cell(i, j);
    }
  }
  
  current = grid[0];
}

void draw() {
  background(255);
  for (int i = 0; i < grid.length; i++) {
    grid[i].show();
  }
  
  current.visited = true;
  current.highlight();
  
  Cell next = current.checkNeighbors();  
  if (next != current) {
    stack.add(current);
    
    removeWalls(current, next);
    current = next;
  } else if (stack.size() > 0) {
    current = stack.get(stack.size()-1);
    stack.remove(stack.size()-1);
  }
}
