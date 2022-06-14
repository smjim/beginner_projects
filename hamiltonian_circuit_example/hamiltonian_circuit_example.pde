int N = 50;

ArrayList<PVector> openSet = new ArrayList<PVector>();
ArrayList<PVector> closedSet = new ArrayList<PVector>();
ArrayList<Edge> edges = new ArrayList<Edge>();

PVector current;

float totalDist = 0;

void setup() {
  size(400, 400);
  background(255);
  
  for (int i = 0; i < N+1; i++) {
    PVector vertex = new PVector(random(width), random(height));
    //PVector vertex = new PVector(width/2 + width/2*cos(i * TWO_PI/N), height/2 + height/2*sin(i * TWO_PI/N));
    openSet.add(vertex);
  }
    
  int r = floor(random(openSet.size()));
  current = openSet.get(r);
}

void draw() {
  if (openSet.size() > 1) {
    closedSet.add(current);
    
    float minDistance = 1e5;
    PVector closestPoint = current;
    float distanceMag = 0;
    
    for (int i = 0; i < openSet.size(); i++) {
      PVector temp = openSet.get(i);  
      distanceMag = temp.copy().sub(current).mag();
      if (distanceMag < minDistance && !closedSet.contains(temp)) { 
        minDistance = distanceMag;
        closestPoint = temp;
      }      
    }
    
    totalDist += distanceMag;

    Edge edge = new Edge(current, closestPoint);
    edges.add(edge);
    current = closestPoint;
    openSet.remove(current);    
  } else {
    println("done");
    println(totalDist);
    noLoop();
  }
  
  for (PVector p : openSet) {
    fill(0);
    noStroke();
    circle(p.x, p.y, 5);
  }
  
  for (Edge e : edges) {
    e.show();
  }
}
