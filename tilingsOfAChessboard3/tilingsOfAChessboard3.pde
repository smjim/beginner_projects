int scl = 20;
boolean[] status;

void setup() {
  size(360, 360);
  status = new boolean[(width*height)/scl];
  
  //for (int i = 0; i < width/scl; i++) {
  //  for (int j = 0; j < height/scl; j++) {
  //    int index = i + j*width/scl;
  //    square(i*scl, j*scl, scl);
  //    status[index] = false;
  //  }
  //}
    
  int blue = 0;
  int red = 0;
  for (int j = 0; j < height/scl; j++) {
    for (int i = 0; i < width/scl; i++) {
      int index = i + j*width/scl;
      if (status[index] == false) {
        int type = floor(random(2));
        if (type == 0) {
          if (status[index + 1] == true || i == width/scl-1) {
            fill(0, 0, 255); blue++;
            rect(i*scl, j*scl, scl, 2*scl);
            status[index] = true;
            status[index + width/scl] = true;
          }
          if (status[index + 1] == false && i < width/scl-1) {
            fill(255, 0, 0); red++;
            rect(i*scl, j*scl, 2*scl, scl);
            status[index] = true;
            status[index + 1] = true;          
          }
        } 
        if (type == 1) {
          if (j < height/scl - 1) {
            fill(0, 0, 255); blue++;
            rect(i*scl, j*scl, scl, 2*scl);
            status[index] = true;
            status[index + width/scl] = true;    
          }
          if (j == height/scl - 1) {
            fill(255, 0, 0); red++;
            rect(i*scl, j*scl, 2*scl, scl);
            status[index] = true;
            status[index + 1] = true; 
          }
        }
      } 
    }
  }
  println(blue, red); 
}
