float xpos, ypos; 

float xspeed = 1.2; 
float yspeed = 0.8; 

int xdirection = 1;  
int ydirection = 1; 

PImage image;

int xsize = 300;
int ysize = int(xsize/1.5);

void setup() {
  //size(512, 256);
  fullScreen();  
  image = loadImage("dvd.jpg");
  image.resize(xsize, ysize);
  xpos = width/2;
  ypos = height/2;
}

void draw() {
  background(0);
  //colorChangeDVD(); //doesnt work because theres no edge detection and its not crisp
  calculateDVD();
  displayDVD();
}

void calculateDVD() {
  //update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-xsize || xpos < 0) {
    xdirection *= -1;
  }
  if (ypos > height-ysize || ypos < 0) {
    ydirection *= -1;
  }
}

void displayDVD() {
  image(image, xpos, ypos);
}

//---------------------------------------------------
