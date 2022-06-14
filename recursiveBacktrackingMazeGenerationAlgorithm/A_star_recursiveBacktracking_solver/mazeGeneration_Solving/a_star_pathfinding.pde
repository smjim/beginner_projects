//import java.util.*;

// An object to describe a spot in the grid
class Spot {
  int i, j;
  // f, g, and h values for A*
  float f = 0;
  float g = 0;
  float heuristic = 0;
  
  // Neighbors
  ArrayList<Spot> neighbors = new ArrayList<Spot>();

  // Where did I come from?
  Spot previous = null;
  
  Spot(int i_, int j_) {
    // Location
    i = i_;
    j = j_;
  }
  
  void show(color col) {
    fill(col);
    rect(i * scl, j * scl, scl, scl);
  }

  // Figure out who my neighbors are
  void addNeighbors(int i, int j) {
    Cell current = cellGrid[i+j*width/scl];
    if (i < cols - 1 && current.right == false) {
      neighbors.add(grid[i + 1][j]);
    }
    if (i > 0 && current.left == false) {
      neighbors.add(grid[i - 1][j]);
    }
    if (j < rows - 1 && current.bottom == false) {
      neighbors.add(grid[i][j + 1]);
    }
    if (j > 0 && current.top == false) {
      neighbors.add(grid[i][j - 1]);
    }
  }
}

float heuristic(Spot a, Spot b) {
  float d = dist(a.i, a.j, b.i, b.j);
  return d;
}
