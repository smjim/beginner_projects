class Edge {
  PVector pos1, pos2;
  
  Edge(PVector _pos1, PVector _pos2) {
    pos1 = _pos1;
    pos2 = _pos2;
  }
  
  void show() {
    strokeWeight(1);
    stroke(0, 0, 255);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }
}
