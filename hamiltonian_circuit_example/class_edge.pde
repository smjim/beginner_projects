class Edge {
  PVector vertex1;
  PVector vertex2;
  
  Edge(PVector point1, PVector point2) {
    vertex1 = point1;
    vertex2 = point2;
  }
  
  void show() {
    stroke(255, 0, 0);
    line(vertex1.x, vertex1.y, vertex2.x, vertex2.y);
  }
}
