float xoff = 0.0;
float increment = 0.001; 
float yoff = 3.6;

int number = 5;

void setup() {
  size(640, 360);
  background(0);
  noStroke();
}

void draw() {
  // Create an alpha blended background
  fill(0, 10);
  rect(0, 0, width, height);
  
  //float n_x = random(0, width);  // random instead of noise
  //float n_y = random(0, height);
  
  // Get a noise value based on xoff and scale it according to the window's width
  float[] n_x = new float[number];
  float[] n_y = new float[number];
  for (int i = 0; i < number; i++) {
    n_x[i] = noise(xoff + 5 * i)*width;
    n_y[i] = noise(yoff + 5 * i)*height;
  }
  
  
  
  // With each cycle, increment xoff
  xoff += increment;
  yoff += increment;
  
  // Draw the ellipse at the value produced by perlin noise
  fill(200);
  for (int i = 0; i < number; i++) {
    circle(n_x[i], n_y[i], 64);
  }
}
