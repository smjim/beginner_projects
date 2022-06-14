float i, x, y, z; //beginshape endshape and vertexes

void setup() {
  size(640,360,P3D);
  background(0);
  lights();
  rotateX(PI/3);
  
  i = 0;
   
  pushMatrix();
  noFill();
  stroke(255);
  sphere(100);
  popMatrix();
}

void draw() {
  background(0);
  x = 50 * sin(i/180)*(2*PI);
  z = 50 * cos(i/180)*(2*PI);
  translate(width/2 + x, height/2, -600 - z);
  sphere(280);
  
  i++;
}

/*size(640, 360, P3D);
background(0);

translate(width/2, height/2, 0);
stroke(255);
rotateX(PI/2);
rotateZ(-PI/6);
noFill();

beginShape();
vertex(-100, -100, -100);
vertex( 100, -100, -100);
vertex(   0,    0,  100);

vertex( 100, -100, -100);
vertex( 100,  100, -100);
vertex(   0,    0,  100);

vertex( 100, 100, -100);
vertex(-100, 100, -100);
vertex(   0,   0,  100);

vertex(-100,  100, -100);
vertex(-100, -100, -100);
vertex(   0,    0,  100);
endShape();*/
