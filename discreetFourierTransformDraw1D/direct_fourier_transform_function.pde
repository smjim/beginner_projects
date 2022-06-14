Fourier[] dft(FloatList x) {
  int N = x.size();
  Fourier[] X = new Fourier[N];
  
  for (int k = 0; k < N; k++) {
    PVector a = new PVector(0, 0);
    
    for (int n = 0; n < N; n++) {
      float phi = TWO_PI*k*n/N; //angle from euler's formula
      float re = x.get(n)*(cos(phi));
      float im = x.get(n)*(-sin(phi));
      
      a.x += re;
      a.y += im;
      //a.normalize().mult(x.get(n));
    }
    a.div(N);
    
    float frequency = k+1;
    float amp = a.mag();
    float phase = atan2(a.y, a.x);
    
    X[k] = new Fourier(a.x, a.y, frequency, amp, phase);
  }
  
  return X;
}

class Fourier {
  PVector a; //complex location
  float frequency;
  float amplitude;
  float phase;
  
  Fourier(float re, float im, float freq, float amp, float phas) {
    a = new PVector(re, im);
    frequency = freq;
    amplitude = amp;
    phase = phas;
  }
}
