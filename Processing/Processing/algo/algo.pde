int scl = 40;

void setup() {
  size(360, 360);
  background(255);
  
  //draw boxes and circles
  for (int i = 0; i < width/scl; i++) {
    for (int j = 0; j < height/scl; j++) {
      stroke(0);
      if (floor(random(2)) == 1) {
        fill(0);        
      } else {
        fill(255);
      }
      circle((i+0.5)*scl, (j+0.5)*scl, scl/2.5);
    }
  }
  for (int i = 0; i < width/scl - 1; i++) {
    for (int j = 0; j < height/scl - 1; j++) {
      stroke(0);
      noFill();
      square((i+0.5)*scl, (j+0.5)*scl, scl);
    }
  }
  
  //loop over all [squares] within set
    //determine configuration (isovalue)
    //use lookup table to assign edges
    //draw edges
    
  
}

//void isovalue(Nod) {
//  int a, b, c, d;
//  if () {
    
//  }
//}
