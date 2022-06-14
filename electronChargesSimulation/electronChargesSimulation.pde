Charge[] charges = new Charge[10];

void setup() {
  size(800, 600);
  //fullScreen();
  for (int i = 0; i < charges.length; i++) {
    charges[i] = new Charge(random(-1, 1), random(0, width), random(0, height));
  }
}

void draw() {
  background(0);
  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = x + y * width;
      float sum = 0;
      for (Charge c : charges) {
        float d = dist(x, y, c.position.x, c.position.y)/1e3;
        if (d == 0) {d=1;}
        sum += 1e1 * c.charge / d;
      }
      pixels[index] = color(127+sum, 0, 127-sum);
    }
  }
  updatePixels();
  for (Charge c : charges) {
    c.acceleration.set(0,0);
    for (Charge other : charges) {
      if (other != c) {
        c.checkChargeCollisions(other);
        c.calculateForces(other);
      }
    }
    c.displayFields();
    c.calculateKinematics();
    c.checkWallCollisions();
  }
  chargeObservation();
}

void chargeObservation() {
  stroke(255);
  noFill();
  circle(mouseX, mouseY, 200);
  
  float chargeSum = 0;
  PVector mousePosition = new PVector(mouseX, mouseY);
  for (Charge c : charges) {
    PVector distanceVect = PVector.sub(c.position, mousePosition);
    float distanceVectMag = distanceVect.mag();
    
    if (distanceVectMag < 100) {
      chargeSum += c.charge;
    }
  }
  
  stroke(0);
  text(chargeSum, mouseX, mouseY);
}
