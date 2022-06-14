//for the circle calculations
int offset = 0;
int number = 20;    //number of asteroids
float Radius = 50; //radius of the asteroid
float radius = 1;  //radius of the outline of the shape

float[][] data = new float[number][360];
PVector[] pos = new PVector[number];
PVector[] vel = new PVector[number];

void setup() {
  noStroke();
  
  //size(360, 360);
  fullScreen();
  background(0);
  asteroids();
}

void draw() {
  //fill(0, 10);
  //rect(0, 0, width, height);
  background(0);
  calculateAndDraw();
}

void asteroids() {
  for (int i = 0; i < number; i++) {
    
    //position and velocity
    pos[i] = new PVector(random(width), random(height));
    vel[i] = new PVector(random(-1, 1), random(-1, 1));
    
    //the radius shape of the asteroid
    for (int j = 0; j < 359; j++) {
      float x = Radius * cos(j * PI / 180);
      float y = Radius * sin(j * PI / 180); 
      
      data[i][j] = 100 * noise(x/100 + offset, y/100 + offset);
    
      x = pos[i].x + (data[i][j] * cos(j * PI / 180));
      y = pos[i].y + (data[i][j] * sin(j * PI / 180)); 
      
      fill(255);
      circle(x, y, radius); 
    }
    offset++;
  }
}  

void calculateAndDraw() {
  for (int i = 0; i < number; i++) {
    pos[i].x += vel[i].x;
    pos[i].y += vel[i].y;
    
    //go to the other side of the screen
    if (pos[i].x+Radius < 0) {
      pos[i].x = width+Radius;
    }
    if (pos[i].x-Radius > width) {
      pos[i].x = -Radius;
    }
    if (pos[i].y+Radius < 0) {
      pos[i].y = height+Radius;
    }
    if (pos[i].y-Radius > height) {
      pos[i].y = -Radius;
    }
    
    /* //bounce off the sides
    if (pos[i].x-Radius < 0 || pos[i].x+Radius > width) {
      vel[i].x *= -1;
    }
    if (pos[i].y-Radius < 0 || pos[i].y+Radius > height) {
      vel[i].y *= -1;
    }
    */
    
    for (int j = 0; j < 359; j++) {
      float x = pos[i].x + (data[i][j] * cos(j * PI / 180));
      float y = pos[i].y + (data[i][j] * sin(j * PI / 180)); 
      
      fill(255);
      circle(x, y, 5); 
    }
  }
}
