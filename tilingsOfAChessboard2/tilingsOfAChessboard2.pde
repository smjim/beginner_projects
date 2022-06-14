int scl = 20;
boolean[] status;

void setup() {
  size(360, 360);
  status = new boolean[(width*height)/scl];
  frameRate(10);
  
  for (int i = 0; i < width/scl; i++) {
    for (int j = 0; j < height/scl; j++) {
      int index = i + j*width/scl;
      square(i*scl, j*scl, scl);
      status[index] = false;
    }
  }
  
  //for (int i = 0; i < width/scl; i++) {
  //  for (int j = 0; j < height/scl; j++) {
  //    int index = i + j*width/scl;
  //    if (status[index] == false) {
  //      int type = floor(random(2));
  //      if (type == 0 && status[index + 1] == false) {
  //        rect(i*scl, j*scl, 2*scl, scl);
  //        status[index] = true;
  //        status[index + 1] = true;
  //      } else {
  //        rect(i*scl, j*scl, scl, 2*scl);
  //        status[index] = true;
  //        status[index + width/scl] = true;
  //      }
  //      if (type == 1 && status[index + width/scl] == false) {
  //        rect(i*scl, j*scl, scl, 2*scl);
  //        status[index] = true;
  //        status[index + width/scl] = true;
  //      }
  //    }
  //  }
  //}
}

int i = 0;
int j = 0;
void draw() {
  fill(100);
  int index = i + j*width/scl;
      if (status[index] == false) {
        int type = floor(random(2));
        if (type == 0 && status[index + 1] == false && i < width/scl-1) {
          rect(i*scl, j*scl, 2*scl, scl);
          status[index] = true;
          status[index + 1] = true;
        } else {
          rect(i*scl, j*scl, scl, 2*scl);
          status[index] = true;
          status[index + width/scl] = true;
        }
        if (type == 1 && status[index + width/scl] == false && j < height/scl - 1) {
          rect(i*scl, j*scl, scl, 2*scl);
          status[index] = true;
          status[index + width/scl] = true;
        }
      }
      
      i++;
      if (i == width/scl) {
        i =0;
        j++;
      }
}
