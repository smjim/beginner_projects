//for the circle calculations
int i = 0;
int offset = 0;

void setup() {
  size(360, 460);
  background(0);
}

void draw() {
  circularNoise();
}

void circularNoise() {
  noStroke();
  int radius = width/2 - 5;
  
  float x = (360/2) + (radius * cos(i * PI / 180));
  float y = (360/2) + (radius * sin(i * PI / 180)); 

  fill(0);
  rect(x-5, y-5, 10, 10);
  stroke(255);
  point(x, y);
  
  float data = 100 * noise(x/100 + offset, y/100 + offset);
  heightData(i, data);
  drawBlob(data);
  i++;
  
  if (i > 360) {
    noStroke();
    i = 0;
    fill(0);
    background(0);
    offset++;
  }
}

void heightData(float x, float data) {
  stroke(255);
  point(x, height-data);
}

void drawBlob(float data) {
  noStroke();
  fill(255);
  
  float x = (360/2) + (data * cos(i * PI / 180));
  float y = (360/2) + (data * sin(i * PI / 180)); 
  
  circle(x, y, 5);
}
