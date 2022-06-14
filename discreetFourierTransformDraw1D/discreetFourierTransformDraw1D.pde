float time = 0;
FloatList wave;

FloatList y;
Fourier[] fourierY;

void setup() {
  size(600, 400);
  wave = new FloatList();
  y = new FloatList();
  
  //y.append(110);  
  //y.append(14);
  //y.append(20);
  //y.append(38);
  //y.append(74);
  for (int i = 0; i < 100; i++) {
    //y.append(1e2*noise(i/1e2));
    y.append(random(-300, 300));
    //y.append(i);
    //y.append(100);
    //println(y.get(i));
  }
  
  fourierY = dft(y);
}

void draw() {
  background(0);
  
  translate(200, 200);
  
  float x = 0;
  float y = 0;
    
  for (int i = 0; i < 5; i++) {
    float previousX = x;
    float previousY = y;
     
    float frequency = fourierY[i].frequency;
    float radius = fourierY[i].amplitude;
    float phase = fourierY[i].phase;
    x += radius * cos(frequency * time + phase);
    y += radius * sin(frequency * time + phase);
    
    
    noFill();
    stroke(255, 100);
    circle(previousX, previousY, radius*2);
  
    stroke(255);
    line(previousX, previousY, x, y);
  }

  wave.reverse();
  wave.append(y);
  wave.reverse();
  
  if (wave.size() > 400) {
    wave.remove(400);
  }
  
  line(x, y, 100, y); 
  circle(100, y, 8);

  translate(100, 0);  
  noFill();
  beginShape();
  for (int i = wave.size()-1; i > 0; i--) {
    vertex (i, wave.get(i));
  }
  endShape();
 
  float dt = TWO_PI / fourierY.length;
  time += dt;
}
