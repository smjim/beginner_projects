int size = 8;
color[] boxcolor = new color[int(pow(size, 2))];

float off = 0.01;

void setup() {
  size(600,600);
  background(0);  
  boxborders();
  calculateboxes();
}

void draw() {
  boxdata();
}

int index(int x, int y) {
  int index = x + y * size;
  return index;
}

void calculateboxes() {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      int index = index(i, j);
      boxcolor[index] = color(random(255));
    }
  }
}

void boxdata() {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      int index = index(i, j);
      fill(boxcolor[index]);
      rect(i * width/size, j * width/size, width/size - 1, height/size - 1);
    }
  }
}

void boxborders() {
  stroke(0);
  for(int i=0; i<width; i+=width/size){
    line(i,0,i,height);
  }
  for(int w=0; w<height; w+=height/size){
    line(0,w,width,w);
  }   
}
