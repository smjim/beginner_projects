float xincrement = 0.002;
float yincrement = 0.002;
float zincrement = 0.008; //time

float zoff = 0.00;

//choose color scheme
int iwant = 3;

void setup() {
  size(400, 400);
  //fullScreen();
  background(255);
}

void draw() {
  fitnessMap();
}

void fitnessMap() {
  loadPixels();
  float xoff = 0.0; 
  noiseDetail(2);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += xincrement;
    float yoff = 0.0; // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += yincrement;
      
      float value = noise(xoff, yoff, zoff);
      
      //60s palette
      if (iwant == 0) {
        if (value > 0.1 && value < 0.11) {pixels[x + y * width] = color(58,44,32);}
        if (value > 0.2 && value < 0.21) {pixels[x + y * width] = color(182,92,17);}
        if (value > 0.3 && value < 0.31) {pixels[x + y * width] = color(231,165,4);}
        if (value > 0.4 && value < 0.41) {pixels[x + y * width] = color(113,152,66);}
        if (value > 0.5 && value < 0.51) {pixels[x + y * width] = color(144,27,27);} 
        //fill the spaces between the bands (if not active then the bands draw over each other)
        if (value > 0 && value < 0.1) {pixels[x + y * width] = color(255, 255, 255);}
        if (value > 0.11 && value < 0.2) {pixels[x + y * width] = color(255, 255, 255);}
        if (value > 0.21 && value < 0.3) {pixels[x + y * width] = color(255, 255, 255);}
        if (value > 0.31 && value < 0.4) {pixels[x + y * width] = color(255, 255, 255);}
        if (value > 0.41 && value < 0.5) {pixels[x + y * width] = color(255, 255, 255);}
        if (value > 0.51 && value < 1) {pixels[x + y * width] = color(255, 255, 255);}
      }
      
      //rgb palette
      if (iwant == 1) {
        if (value > 0.1 && value < 0.15) {pixels[x + y * width] = color(0,0,255);}
        if (value > 0.3 && value < 0.35) {pixels[x + y * width] = color(0,255,0);}
        if (value > 0.5 && value < 0.55) {pixels[x + y * width] = color(255,0,0);} 
        //fill the spaces between the bands (if not active then the bands draw over each other)
        if (value > 0 && value < 0.1) {pixels[x + y * width] = color(0, 0, 0);}
        if (value > 0.15 && value < 0.3) {pixels[x + y * width] = color(0,0,0);}
        if (value > 0.35 && value < 0.5) {pixels[x + y * width] = color(0,0,0);}
        if (value > 0.55 && value < 1) {pixels[x + y * width] = color(0,0,0);} 
      }
         
      //minecraft palette      
      if (iwant == 2) {
        if (value > 0 && value < 0.19) {pixels[x + y * width] = color(#00008b);}
        if (value > 0.19 && value < 0.31) {pixels[x + y * width] = color(#0000ff);}
        if (value > 0.31 && value < 0.35) {pixels[x + y * width] = color(#c2b280);}
        if (value > 0.35 && value < 0.45) {pixels[x + y * width] = color(#7cfc00);}
        if (value > 0.45 && value < 1) {pixels[x + y * width] = color(#1e932d);}
      }    
      
      //green and black
      if (iwant == 3) {
        if (value > 0.1 && value < 0.11) {pixels[x + y * width] = color(#00ff00);}
        if (value > 0.2 && value < 0.21) {pixels[x + y * width] = color(#00ff00);}
        if (value > 0.3 && value < 0.31) {pixels[x + y * width] = color(#00ff00);}
        if (value > 0.4 && value < 0.41) {pixels[x + y * width] = color(#00ff00);}
        if (value > 0.5 && value < 0.51) {pixels[x + y * width] = color(#00ff00);}
        //fill in the spaces between the bands
        if (value > 0 && value < 0.1) {pixels[x + y * width] = color(#000000);}
        if (value > 0.11 && value < 0.2) {pixels[x + y * width] = color(#000000);}
        if (value > 0.21 && value < 0.3) {pixels[x + y * width] = color(#000000);}
        if (value > 0.31 && value < 0.4) {pixels[x + y * width] = color(#000000);}
        if (value > 0.41 && value < 0.5) {pixels[x + y * width] = color(#000000);}
        if (value > 0.51 && value < 1) {pixels[x + y * width] = color(#000000);}
      }
    }
  }
  
  zoff += zincrement;
  
  updatePixels();
}
