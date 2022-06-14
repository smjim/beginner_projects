float increment = 0.02;

void setup() {
  size(360, 360);
  background(255);
}

void draw() {
  fitnessMap(); //from processing.org/examples/noise2d.html by Daniel Shiffman
}

void fitnessMap() {
  loadPixels();
  float xoff = 0.0; 
  noiseDetail(2);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;
    float yoff = 0.0; // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment;
      //color bright = color(0, 0, noise(xoff, yoff) * 255);
      //pixels[x+y*width] = color(bright);
      float value = noise(xoff, yoff);
      if (value > 0.1 && value < 0.15) {pixels[x + y * width] = color(58,44,32);}
      if (value > 0.2 && value < 0.22) {pixels[x + y * width] = color(182,92,17);}
      if (value > 0.3 && value < 0.36) {pixels[x + y * width] = color(231,165,4);}
      if (value > 0.4 && value < 0.45) {pixels[x + y * width] = color(113,152,66);}
      if (value > 0.5 && value < 0.55) {pixels[x + y * width] = color(144,27,27);}
    }
  }
  
  updatePixels();
}
