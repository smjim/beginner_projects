int cols, rows;
int scl = 200;
Cell[] grid;
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

PVector position, velocity;
float theta;
PVector forward;

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
  
  
  while (openSet.size() > 0) {
    float minWeight = 100;
    Cell current = null;
    Cell next = null;
    
    for (int i = 0; i < closedSet.size(); i++) {
      Cell c = closedSet.get(i);
      
      for (int j = 0; j < c.neighbors.size(); j++) {
        Cell temp = c.neighbors.get(j);
        float tempWeight = c.weights.get(j);
        
        if (tempWeight < minWeight && !closedSet.contains(temp)) {
          minWeight = tempWeight;
          next = temp;
          current = c;
        }
      }
    }
    
    removeWalls(current, next);
    openSet.remove(next);
    closedSet.add(next);        
  } 

  position = new PVector(scl/2, scl/2);
  velocity = new PVector(0, 0);
  theta = PI/2;
}

void draw() { 
  //show boxes
  for (Cell c : grid) {
    c.show(255);
    //c.show(color(0, 255, 255));
  }
  
  calculateKinematics();
  
  //noStroke();
  //fill(255, 0, 255);
  //if (mousePressed) {
  //  circle(mouseX, mouseY, 10);
  //}
  
  fill(0);
  noStroke();
  circle(position.x, position.y, scl/8);
  
  stroke(0, 255, 0);
  line(position.x, position.y, position.x + forward.x*1e2, position.y + forward.y*1e2);
  
  
}

void calculateKinematics() {
  PVector gravity = new PVector(0, 1e-2, 0);
  position.add(velocity);
  velocity.add(gravity);
  
  forward = PVector.fromAngle(theta);
  
  //friction
  velocity.div(1.01);
  
  //limit velocity
  float velMag = velocity.mag();
  velocity.normalize().mult(min(1e1, velMag));
}

void keyPressed() {
  float mag = 1e-1;
  float increment = 1e-1;
  if (key == 'w') {
    PVector acceleration = PVector.fromAngle(theta);
    velocity.add(acceleration.mult(mag));
    //position.add(acceleration.mult(mag));
  }
  if (key == 'a') {
    theta -= increment;
  }
  if (key == 'd') {
    theta += increment;
  }
}
