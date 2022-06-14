class Charge {
  PVector pos;
  float charge;
  
  Charge(float x, float y, float c) {
    pos = new PVector(x, y);
    charge = c;
  }
  
  void show() {
    if (charge > 0) {
      fill(255, 0, 0);
    } else if (charge < 0) {
      fill(0, 0, 255);
    }
    noStroke();
    circle(pos.x, pos.y, 10);
  }
}
