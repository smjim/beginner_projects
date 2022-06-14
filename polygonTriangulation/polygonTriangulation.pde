PVector[] points = new PVector[10];

ArrayList<PVector> openSet = new ArrayList<PVector>();
ArrayList<PVector> closedSet = new ArrayList<PVector>();
ArrayList<Edge> edges = new ArrayList<Edge>();

float increment;

void setup() {
  size(400, 400);
  //frameRate(10);
  increment = width;
  
  for (int i = 0; i < points.length; i++) {
    PVector p = new PVector(random(width), random(height));
    points[i] = p;
    openSet.add(p);
  }
}

void draw() {
  background(255);
  
  if (openSet.size() > 0) {
    //scan from right to left
    stroke(255, 0, 0);
    line(increment, 0, increment, height);
    
    if (closedSet.size() >= 2) {
      for (int i = 0; i < openSet.size(); i++) {
        PVector p = openSet.get(i);
        if (increment < p.x) {
          //make the edge to the correct points (2 points from closedset that have the greatest x/ the last two added)
            //find the correct points
              //PVector point1 = closedSet.get(closedSet.size() - 1);
              //PVector point2 = closedSet.get(closedSet.size() - 2);
              PVector point1 = new PVector(0,0);
              PVector point2 = new PVector(0,0);
              float minDistMag = sqrt(pow(width,2)+pow(height,2));
              for (int j = 0; j < closedSet.size(); j++) {
                PVector o = closedSet.get(j);
                float distMag = o.copy().sub(p).mag();
                if (distMag < minDistMag) {
                  point2 = point1;
                  point1 = o;
                  minDistMag = distMag;
                }
              }
            //make the edges
              Edge edge1 = new Edge(p, point1);
              Edge edge2 = new Edge(p, point2);
              edges.add(edge1);
              edges.add(edge2);
          //remove from openslist
          openSet.remove(p);
          closedSet.add(p);
        }
      }  
    } else { //when there are less than 2 points in closedset
      //add the points to closedset
        for (int i = 0; i < openSet.size(); i++) {
          PVector p = openSet.get(i);
          if (increment < p.x) {
            if (closedSet.size() == 1) {
              Edge edge = new Edge(p, closedSet.get(0));
              edges.add(edge);
            }
            openSet.remove(p);
            closedSet.add(p);
          }
        }
      //if theres a point already in closedset then make an edge to it
    }
    
    increment --;
  } else {
    noLoop();
    println("done");
  }
  
  for (Edge e : edges) {
    e.show();
  }
  for (PVector p : points) {
    stroke(0);
    strokeWeight(2);
    circle(p.x, p.y, 5);
  }
}
