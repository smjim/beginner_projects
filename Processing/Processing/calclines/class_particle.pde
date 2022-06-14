class Particle {
  PVector pos;
  float charge = 1;
  
  ArrayList<PVector> line = new ArrayList<PVector>();
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
  }
  
  PVector calculateForces(Charge c) {
    PVector distanceVect = c.pos.copy().sub(pos);
    float distanceVectMag = distanceVect.mag();
    float forceMag;
    
    //coulomb's law
    float k = 1; // k should be 9e9 but the charges are input 1:1e-9C
    if (distanceVectMag > 1e1) {
      forceMag = k*(charge)*(c.charge)/(pow(distanceVectMag, 2));
    } else {
      forceMag = 0;
    }
    
    PVector force = distanceVect.normalize();
    force.mult(1e3*forceMag);
      
    return force;
  }
  
  void followForces(PVector forceVect) {
    //it needs to be -= so that it will be attracted to the negatives and repelled from positives
    pos.x -= forceVect.x;
    pos.y -= forceVect.y;
  }
  
  void showPath() {
    line.add(new PVector(pos.x, pos.y));
    
    stroke(0);
    noFill();
    beginShape();
    for (PVector p : line) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
