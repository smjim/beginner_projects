ArrayList<Particle> particleList;

//for the particle interaction
PVector mousePosition1;
PVector mousePosition2;
boolean active;
float mass;
String size = "";

void setup() {
  size(640, 360);
  //fullScreen();
  background(0);
  stroke(255);
  noFill();
  
  particleList = new ArrayList<Particle>();
  
  ////initiate a bunch of particles
  //for (int i = 0; i < 100; i++) {
  //  PVector pos = new PVector(random(0, width), random(0, height));
  //  PVector vel = new PVector(0, 0);
  //  particleList.add(new Particle(pos, random(1, 100), vel));
  //}
}

void draw() {
  background(0);
  
  for (int i = 0; i <= particleList.size() - 1; i++) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Particle p = particleList.get(i);
    for (int j = 0; j <= particleList.size() - 1; j++) { 
      Particle o = particleList.get(j);
      p.calculateForces(o);
      p.checkParticleCollisions(o);
    }
    p.calculateKinematics();
    p.show();
    //p.showMasses();
  }
  
  //mouse interaction
  if (active == true) {
    stroke(255, 0, 0);
    line(mousePosition1.x, mousePosition1.y, mouseX, mouseY);
  }
  
  //type in the mass that you want
  if (size.length() > 0) {
    mass = Float.valueOf(size);
  }

  fill(255);
  textSize(25);
  text("Mass: " + size, 10, 30);
}


//mouse/ typing interaction
void mousePressed() {
  active = true;
  mousePosition1 = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  active = false;
  PVector mousePosition2 = new PVector(mouseX, mouseY);
  PVector vel = mousePosition1.copy().sub(mousePosition2).div(1e1);
  particleList.add(new Particle(mousePosition1, mass, vel));
}

void keyPressed() {
  size = size + String.valueOf(key);
  if (key == ENTER) {
    size = "";
  }
  if (key == BACKSPACE) {
    for (int i = 0; i < particleList.size(); i++) {
      particleList.remove(i);
    }
  }
}
