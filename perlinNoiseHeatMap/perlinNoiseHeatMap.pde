float increment = 0.01;

void setup() {
  colorMode(HSB);
  size(360, 360);
}

void draw() {
  fitnessMap(); 
}

void fitnessMap() {
  loadPixels();
   
  noiseDetail(1);
  
  float xoff = 0.0;
  for (int x = 0; x < width; x++) {
    xoff += increment;
    float yoff = 0.0; 
    for (int y = 0; y < height; y++) {
      yoff += increment;
      pixels[x+y*width] = color(255*noise(xoff, yoff), 255, 255);
    }
  }
  
  updatePixels();
}
