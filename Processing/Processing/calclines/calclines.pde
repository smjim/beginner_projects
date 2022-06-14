ArrayList<Charge> charges = new ArrayList<Charge>();
ArrayList<Particle> particles = new ArrayList<Particle>();

int scl = 20;

void setup() {
  size(400, 400);
  //fullScreen();
  for (int i = 0; i < 100; i++) {
    charges.add(new Charge(random(width), random(height), random(-1, 1)));
  }
  
  //draw the lines eminating from a grid over the entire board
  for (int j = 0; j < height/scl; j++) {
    for (int i = 0; i < width/scl; i++) {
      Particle p = new Particle(i*scl, j*scl);
      particles.add(p);
    }
  }
}

void draw() {
  background(255);
  for (Particle p : particles) {
    PVector forceVect = new PVector(0, 0);
    for (Charge c : charges) {
      forceVect.add(p.calculateForces(c));
    }
    p.followForces(forceVect);
    p.showPath();
  }
  for (Charge c : charges) {
    c.show();
  }
}

void keyPressed() {
  noLoop();
  println("stopped");
}
