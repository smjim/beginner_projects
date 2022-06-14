PVector[] points = new PVector[100];
ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<PVector> openSet = new ArrayList<PVector>();
ArrayList<PVector> closedSet = new ArrayList<PVector>();

PVector current;

void setup() {
  //frameRate(10);
  size(600, 600);
  background(255);
  
  for (int i = 0; i < points.length; i++) {
    //randomSeed(100*int(random(i)));
    points[i] = new PVector(random(width), random(height));
    openSet.add(points[i]);
  }
  
  for (int i = 0; i < points.length; i++) {
    fill(255);
    stroke(0);
    strokeWeight(1);
    circle(points[i].x, points[i].y, 10);
  }
  
  //initialize the first node in the tree
  int r = floor(random(points.length));
  current = points[r];
}

void draw() {
  if (openSet.size() > 0) {
    openSet.remove(current);
    closedSet.add(current);
    
    Edge shortest = null;
    float maxDist = 5e5;
    for (int j = 0; j < closedSet.size(); j++) {
      PVector node = closedSet.get(j);
      for (int i = 0; i < openSet.size(); i++) {
        Edge temp = new Edge(node, openSet.get(i));      
        if (temp.distance < maxDist) {
          maxDist = temp.distance;
          shortest = temp;
        }
      }  
    }
    openSet.remove(shortest.end);
    closedSet.add(shortest.end);
    edges.add(shortest);
    
  } else {
    println("done");
    noLoop();
  }
  
  for (int i = 0; i < edges.size(); i++) {
    Edge line = edges.get(i);
    stroke(255, 0, 0);
    strokeWeight(3);
    line(line.start.x, line.start.y, line.end.x, line.end.y);
  }
}
