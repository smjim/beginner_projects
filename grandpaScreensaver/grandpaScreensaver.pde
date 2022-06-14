int groups = 2;
int nodes = 5;

PVector[][] pos = new PVector[groups][nodes];
PVector[][] velocity = new PVector[groups][nodes];
float[] c = new float[groups];

float speed = 1;

void setup() {
  colorMode(HSB);
  //fullScreen();  
  size(500, 500);
  background(0);
  definePoint();
}

void draw() {
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  calculatePoints();
  drawPoints();
}

void definePoint() {
  for (int i = 0; i < groups; i++) {
    c[i] = random(255);
    for (int j = 0; j < nodes; j++) {
      pos[i][j] = new PVector(random(1, width-1), random(1, height-1));
      velocity[i][j] = new PVector(speed*random(2), speed*random(2));
    }
  }
}

void calculatePoints() {
  //update the position of the shape
  
  for (int i = 0; i < groups; i++) {
    for (int j = 0; j < nodes; j++) {
      pos[i][j].x += ( velocity[i][j].x );
      pos[i][j].y += ( velocity[i][j].y );
      
      // box border
      if (pos[i][j].x > width-1/2 || pos[i][j].x < 1/2) {
        velocity[i][j].x *= -1;
      }
      if (pos[i][j].y > height-1/2 || pos[i][j].y < 1/2) {
        velocity[i][j].y *= -1;
      }
    }
  }
}

void drawPoints() {
  fill(255);
  
  for (int i = 0; i < groups; i++) {  
    stroke(color(c[i], 255, 255));
    c[i] += 0.5;
    if (c[i] > 255) {
      c[i] = 0;
    }
    for (int j = 0; j < nodes; j++) {
      //circle(pos[i][j].x, pos[i][j].y, 1);
    } 
    for (int j =  0; j < nodes-1; j++) {
      line(pos[i][j].x, pos[i][j].y, pos[i][j+1].x, pos[i][j+1].y);
    }
    line(pos[i][0].x, pos[i][0].y, pos[i][nodes-1].x, pos[i][nodes-1].y);
  }
}
