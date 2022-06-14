//for the circle calculations
int offset = 0;

void setup() {
  frameRate(2);
  
  size(360, 360);
  background(0);
  circularNoise();
}

void draw() {
  fill(0, 150);
  rect(0, 0, width, height);
  circularNoise();
}

void circularNoise() {
  for (int i = 0; i < 360; i++) {
    noStroke();
    int radius = width/2 - 5;
    
    float x = (360/2) + (radius * cos(i * PI / 180));
    float y = (360/2) + (radius * sin(i * PI / 180)); 
    
    float data = 100 * noise(x/100 + offset, y/100 + offset);
    noStroke();
    fill(255);
  
    x = (360/2) + (data * cos(i * PI / 180));
    y = (360/2) + (data * sin(i * PI / 180)); 
    
    circle(x, y, 5); 
  }
  offset++;
}
