int N = 10;

float[] xpos = new float[N];
float[] ypos = new float[N];

float[] xspeed = new float[N]; 
float[] yspeed = new float[N];

float[] xdirection = new float[N];  
float[] ydirection = new float[N]; 

int radius = 5;

void setup() {
  fullScreen();
  //size(512, 256);
  for (int i = 0; i < N; i++) {
    xpos[i] = random(width);
    ypos[i] = random(height);
    
    xspeed[i] = random(3) + 2;
    yspeed[i] = random(3) + 2;
    
    xdirection[i] = random(2) - 1;
    ydirection[i] = random(2) - 1;
  }
}

void draw() {
  background(0);
  calculatePoints();
  fill(255);
  stroke(255);
  for (int i = 0; i < N-1; i++) {
    circle(xpos[i], ypos[i], 5);
    /*
    for (int j = 0; j < N; j++) {
      line(xpos[i], ypos[i], xpos[j], ypos[j]);
    } */
    circle(xpos[i+1], ypos[i+1], 5);
    line(xpos[i], ypos[i], xpos[i+1], ypos[i+1]);
  }
}

void calculatePoints() {
  //update the position of the shape
  
  for (int i = 0; i < N; i++) {
    xpos[i] = xpos[i] + ( xspeed[i] * xdirection[i] );
    ypos[i] = ypos[i] + ( yspeed[i] * ydirection[i] );
    
    // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (xpos[i] > width-radius || xpos[i] < radius) {
      xdirection[i] *= -1;
    }
    if (ypos[i] > height-radius || ypos[i] < radius) {
      ydirection[i] *= -1;
    }
  }
}
