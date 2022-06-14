class Particle {

  PVector pos;
  PVector vel;
  PVector acc;
  PVector f;
  
  Particle() {
    //pos = new PVector(random(width), random(height));    
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    //vel = new PVector(random(-5e-1,5e-1), random(-5e-1,5e-1));
    acc = new PVector(0, 0);
  }
  
  void update() {
    vel.add(acc);
    
    //limit velocity
    vel.setMag(min(vel.mag(), 5));
    
    //friction
    vel.div(1.005);
    
    pos.add(vel);
    acc.mult(0);
  }
  
  void follow(PVector[] flowField) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    
    int index = x + y*cols;
    //prevent out of bounds error
    if (index < flowField.length) {
      f = flowField[index].mult(1e-1);
    }
  }
  
  void applyForce() {
    acc.add(f);
  }
  
  void show() {
    stroke(0);
    point(pos.x, pos.y);
    //circle(pos.x, pos.y, 10);
  }
  
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }    
    if (pos.y > height) {
      pos.y = 0;
    }    
    if (pos.y < 0) {
      pos.y = height;
    }    
  }
}
