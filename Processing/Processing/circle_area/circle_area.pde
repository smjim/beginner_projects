float theta, r;  
float A1, A2;
float rayLength;

void setup() {
  size(400,400);
  background(0);
  r = 100;
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  //stroke(0, 255, 0);
  //line (width/2, height/2, width/2 + r*cos(0), height/2 + r*sin(0));
  //line(width/2, height/2, width/2 + r*cos(theta), height/2 + r*sin(theta));
  stroke(255, 0, 0);
  line(width/2 + r*cos(theta), height/2 + r*sin(theta), width/2 + r*cos(0), height/2 + r*sin(0));
  //fill(0, 255, 0, 50);
  //noStroke();
  //triangle(width/2, height/2, width/2 + r*cos(theta), height/2 + r*sin(theta), width/2 + r*cos(0), height/2 + r*sin(0));
  noFill();
  if (0 <= theta && theta <= PI) {
    //stroke(255);
    //arc(width/2, height/2, r*2, r*2, theta, 2*PI);
    stroke(255, 0, 0);
    arc(width/2, height/2, 2*r, 2*r, 0, theta);
  }
  if (-PI <= theta && theta < 0) {
    //stroke(255);
    //arc(width/2, height/2, 2*r, 2*r, theta, 0);
    stroke(255, 0, 0);
    arc(width/2, height/2, 2*r, 2*r, 0, PI);
    arc(width/2, height/2, 2*r, 2*r, -PI, theta);
  }
  
  calcAreas();
  //drawAreas();
  //println(theta/PI, " pi");
  theta = atan2((mouseY - height/2), (mouseX - width/2));
  fill(0, 255, 0);
  text("A1:" + A1, 10, 20);
  fill(255, 0, 0);
  text("A2: " + A2, 10, 40);
  fill(255);
  text("theta: " + theta/PI + " radians", 20, 60);
  text("ray length: " + rayLength, 20, 80);
}

void calcAreas() {
  rayLength = r*sqrt(2*(1-cos(theta)));
  
  // Heron's formula
  float s = (2*r + rayLength)/2;
  A1 = sqrt(s*(s-r)*(s-r)*(s-rayLength));
  
  if (0 <= theta && theta < PI) {
    A2 = PI*r*r*theta/(2*PI) - A1;
  } else if (-PI <= theta && theta < 0) {
    A2 = PI*r*r*(theta+2*PI)/(2*PI) + A1;
  } //else {
  //  print(theta/PI, " pi", "\n");
  //  print("theta restricted to [0, 2pi] range");
  //}
}
