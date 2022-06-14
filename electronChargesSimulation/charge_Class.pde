class Charge {
  
  float charge;
  PVector force;
  PVector position;
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  
  Charge(float value, float xpos, float ypos) {
    charge = value;
    position = new PVector(xpos, ypos);
  }
  
  void calculateForces(Charge other) { // adapted from processing.org/expamples/circlecollision.html Ira Greenburg
    //get distance between the charges
    PVector distanceVect = PVector.sub(other.position, position);
    
    //calculate magnitude of the vector separating the charges
    float distanceVectMag = distanceVect.mag();
    
    //Coulomb's law (input charge in mili Coulombs (1e-6) so k goes from (9e9) to (9e3))
    float forceMag = 9e3 * other.charge * charge / pow(distanceVectMag, 2);
    //limit it so that it isnt infinity when distance is 0
    //forceMag = min(forceMag, 1);
       
    //make force vector point in correct angle, then normalize and scale to magnitude
    force = new PVector(other.position.x - position.x, other.position.y - position.y);
    force.normalize();
    force.mult(-forceMag);
    
    //stroke(0);
    //line(position.x, position.y, position.x + 1e4*force.x, position.y + 1e4*force.y);
    
    //acceleration = force;
    acceleration.add(force);
    //limit acceleration
    float accelerationMag = acceleration.mag();
    acceleration.normalize().mult(min(accelerationMag, 3e-2));
  }
  
  void calculateKinematics() {  
    position.add(velocity); 
    velocity.add(acceleration); 
  }
  
  void checkChargeCollisions(Charge other) {
    //get distance between the two charges
    PVector distanceVect = PVector.sub(other.position, position);
    
    //calculate magnitude of the distance between them
    float distanceVectMag = distanceVect.mag();
    
    //min distance apart they must be
    float minDistance = 10;
    
    if (distanceVectMag < minDistance) {
      ////limit velocity and acceleration
      //other.velocity.set(0, 0);
      //velocity.set(0, 0);
      //other.acceleration.set(0, 0);
      //acceleration.set(0, 0);
      
      float distanceCorrection = (minDistance-distanceVectMag);
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);
    }
  }
  
  void checkWallCollisions() {
    //check to see if within the box
    if (position.x < 5) {
      position.x = 5;
    }
    if (position.x > width-5) {
      position.x = width-5;
    }
    if (position.y < 5) {
      position.y = 5;
    }
    if (position.y > height-5) {
      position.y = height-5;
    }
  }
  
  void displayFields() {
    stroke(255);
    line(position.x, position.y, position.x + 1e4*acceleration.x, position.y + 1e4*acceleration.y);
    //stroke(0);
    //line(position.x, position.y, position.x + 1e2*velocity.x, position.y + 1e2*velocity.y);
    noStroke();
    fill(255);
    //circle(position.x, position.y, 1e1*abs(charge));
    fill(0);
    text(charge, position.x, position.y);
  }
  
}
