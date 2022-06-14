class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  PVector force;
  float radius;
  
  Particle(PVector pos, float Mass, PVector vel) {
    position = pos;
    mass = Mass;
    acceleration = new PVector(0,0);
    velocity = vel;
    //density (mass/ area) is preserved with larger circles proportionally sized to larger mass
    radius = sqrt(mass);
  }
  
  void calculateForces(Particle other) { // adapted from processing.org/expamples/circlecollision.html Ira Greenburg
    //get distance between the particles
    PVector distanceVect = PVector.sub(other.position, position);
    
    //calculate magnitude of the vector separating the charges
    float distanceVectMag = distanceVect.mag();
    
    //law of universal gravitation
    float forceMag = 1e1 * other.mass * mass / pow(distanceVectMag, 2);
       
    //make force vector point in correct angle, then normalize and scale to magnitude
    force = new PVector(other.position.x - position.x, other.position.y - position.y);
    force.normalize();
    force.mult(forceMag);
    
    acceleration.add(force.div(mass));
    
    //limit acceleration
    float accelerationMag = acceleration.mag();
    acceleration.normalize().mult(min(accelerationMag, 1e-1));
  }
  
  void calculateKinematics() {  
    position.add(velocity); 
    velocity.add(acceleration); 
    
    //friction
    velocity.div(1.00001);
  }
  
  void checkParticleCollisions(Particle other) {
    //get distance between the two particles
    PVector distanceVect = PVector.sub(other.position, position);
    
    //calculate magnitude of the distance between them
    float distanceVectMag = distanceVect.mag();
    
    if (distanceVectMag < radius/2 + other.radius/2) { 
      ////limit velocity
      velocity.div(1.1);
      ////limit acceleration
      acceleration.set(0, 0);
      other.acceleration.set(0, 0);
      
      float distanceCorrection = ((radius/2 + other.radius/2)-distanceVectMag);
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      position.sub(correctionVector);
      other.position.add(correctionVector);
    }
  }
  
  //void checkWallCollisions() {
  //  //check to see if within the box
  //  if (position.x < 5) {
  //    position.x = 5;
  //  }
  //  if (position.x > width-5) {
  //    position.x = width-5;
  //  }
  //  if (position.y < 5) {
  //    position.y = 5;
  //  }
  //  if (position.y > height-5) {
  //    position.y = height-5;
  //  }
  //}
  
  void show() {
    noFill();
    stroke(255);
    circle(position.x, position.y, radius);
  }
  
  void showMasses() {
    for (int i = 0; i < particleList.size(); i++) {
      text(mass, position.x, position.y);
    }
  }
}
