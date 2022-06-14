int N = 500;

PVector[] pos = new PVector[N];

PVector[] velocity = new PVector[N];

float radius = 5;
float Radius = 20;

void setup() {
  //fullScreen();
  size(500, 500);
  definePoint();
}

void draw() {
  background(0);
  calculatePoints();
  drawPoints();
}

void definePoint() {
  for (int i = 0; i < N; i++) {
    pos[i] = new PVector(width/2 + Radius*cos(2*PI*i/N), height/2 + Radius*sin(2*PI*-i/N));     
    float theta = 90-2*PI*i/N;
    float speed = 0.2;
    velocity[i] = new PVector(speed*cos(theta), speed*sin(theta));
  }
}

void calculatePoints() {
  //update the position of the shape
  
  for (int i = 0; i < N; i++) {
    pos[i].x += ( velocity[i].x );
    pos[i].y += ( velocity[i].y );
    
    // box border
    if (pos[i].x > width-radius/2 || pos[i].x < radius/2) {
      velocity[i].x *= -1;
    }
    if (pos[i].y > height-radius/2 || pos[i].y < radius/2) {
      velocity[i].y *= -1;
    }
  }
}

void drawPoints() {
  stroke(255);
  fill(255);
  for (int i = 0; i < N; i++) {    
    for (int j = 0; j < N; j++) {
      //line(xpos[i], ypos[i], xpos[j], ypos[j]);
    } 
    //circle(pos[i].x, pos[i].y, radius);
  }
  for (int i =  0; i < N-1; i++) {
    line(pos[i].x, pos[i].y, pos[i+1].x, pos[i+1].y);
  }
  line(pos[0].x, pos[0].y, pos[N-1].x, pos[N-1].y);
}
