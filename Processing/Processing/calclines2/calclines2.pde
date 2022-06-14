float increment = 5e-2;
float scl = 20;
int cols, rows;

float zoff = 0;

Particle[] particles = new Particle[100];
PVector[] flowField;

void setup() {
  size(1000,600);
  cols = floor(width/scl);
  rows = floor(height/scl);
  
  flowField = new PVector[rows*cols];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();  
  }  
}

void draw() {
  background(255); 
  float xoff = 0;
  for (int x = 0; x < cols; x++) {
    xoff += increment;
    float yoff = 0.0; 
    for (int y = 0; y < rows; y++) {
      yoff += increment;      
      int index = x + y*cols;
         
      PVector v = new PVector(scl, 0);
      if (mousePressed) {
        //v.rotate(random(0, 2*PI));
        PVector mouse = new PVector(mouseX, mouseY);
        PVector point = new PVector(x*scl, y*scl);
        mouse.sub(point);  
        //float theta = PVector.angleBetween(point, mouse);   
        //v.rotate(theta *PI/2);
        v = mouse.normalize().mult(20);
        //float magnitude = map(0,1,-20,20, noise(xoff, yoff, zoff));
        //v = mouse.normalize().mult(magnitude);
      } else {
        ////change zoff to be something like 0.5
        //float rotation = x-y+zoff;
        //rotation = map(rotation, 0, rows-cols, 0, 2*PI);
        
        //float rotation = floor(x*y/500);
        //rotation = map(rotation, 0, rows*cols/500, 0, 2*PI);
        
        float rotation = 0.5*x+y;
        rotation = map(rotation, 0, 0.5*rows+cols, 0, 2*PI);
        
        v.rotate(rotation);
        
        
        //v.rotate(noise(xoff, yoff, zoff) * 2*PI);
      }
      flowField[index] = v;

      if (keyPressed) {
        translate(x*scl, y*scl);
        stroke(0, 50);
        strokeWeight(4);
        line(0, 0, v.x, v.y); 
        
        float particles_in_box = 0;
        for (Particle p : particles) {
          if (x*scl < p.pos.x && p.pos.x < (x+1)*scl) {
            if (y*scl < p.pos.y && p.pos.y < (y+1)*scl) {
              particles_in_box ++;
            }
          }
        }
        fill(255, 0, 255, 50);
        if (2 <= particles_in_box && particles_in_box < 5) {
          fill(0, 255, 255, 50);
        }
        if (5 <= particles_in_box) {
          fill(255, 255, 0, 50);
        }
        
        translate(-x*scl, -y*scl);
        noStroke();
        rect(x*scl, y*scl, scl, scl);
      }
    }
  }
  println(floor(frameRate)); 
  
  zoff += 0.008;
  
  strokeWeight(4);
  for (int i = 0; i < particles.length; i++) {
    particles[i].follow(flowField);
    particles[i].applyForce();
    particles[i].update();
    particles[i].edges();
    particles[i].show();  
  }
}
