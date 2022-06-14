void setup() {
  size(400, 200);
}

void draw() {
  noFill();
  stroke(255, 0, 0);
  background(255);
  beginShape();                                  //the parabola
  vertex(0, height/2);
  quadraticVertex(width/2, height-mouseY, width, height/2);
  endShape();
  
  fill(0);
  stroke(0);
  circle(width/2, mouseY, 5);                    //focus of the parabola
  line(0, height-mouseY, width, height-mouseY);  //directrix of the parabola
  
  //line(0, height/2, width, height/2);            //the normal of the parabola
}
