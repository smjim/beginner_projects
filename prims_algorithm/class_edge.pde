class Edge {
  PVector start;
  PVector end;
  float distance;
  
  Edge(PVector point1, PVector point2) {
    start = point1;
    end = point2;
    distance = point2.copy().sub(point1).mag();
  }
}
