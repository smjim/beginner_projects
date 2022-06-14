void colorChangeDVD() {
  image.loadPixels();  
  if (xpos > width-xsize || xpos < 0 || ypos > height-ysize || ypos < 0) {   
    
    color c = color(random(255), random(255), random(255));  
    
    for (int j = 0; j < ysize-1; j++) {
      for (int i = 1; i < xsize-1; i++) {
        int index = index(i, j);
        if (image.pixels[index] != color(0)) {
          image.pixels[index] = c;
        }
      }
    }
    
  }
  
  image.updatePixels();
}

int index(int x, int y) {
  return x + y * xsize;
}
