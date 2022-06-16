class Edge {
  float x1, y1;
  float x2, y2;
  
  Edge(float _x1, float _y1, float _x2, float _y2) {
    x1 = _x1 * scl;
    y1 = _y1 * scl;
    x2 = _x2 * scl;
    y2 = _y2 * scl;
  }
}
