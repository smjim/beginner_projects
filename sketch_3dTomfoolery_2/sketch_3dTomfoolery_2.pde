// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/IKB1hWWedMk

int cols, rows;
int scl = 40;
int w = 3000; //there are w/10 points / col
int h = 3000; //there are h/10 points / row

float flying = 0;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}


void draw() {

  flying -= 0.01;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      //terrain[x][y] = map(sin(5*xoff)*cos(5*yoff), -1, 1, -25, 25);
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.1;
    }
    yoff += 0.1;
  }



  background(0);
  stroke(255);
  noFill();

  translate(width/2, height/2+50);
  rotateX(PI/3);
  rotateZ(PI/4);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      point(x*scl, y*scl, terrain[x][y]);
    }
  }
}
