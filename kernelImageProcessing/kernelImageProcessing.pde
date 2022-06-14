PImage image;
PImage intermediary;

float[] sharpen =         {-0.5, -1.0, -0.5,       //sharpen
                           -1.0,  7.0, -1.0,
                           -0.5, -1.0, -0.5};
                  
float[] normal =          {0, 0, 0,                //nothing
                           0, 1, 0,
                           0, 0, 0};

float[] gaussianBlur =    {0.0625, 0.125, 0.0625,  //blur
                           0.125 , 0.25 , 0.125,
                           0.0625, 0.125, 0.0625};
                  
float[] blur =            {0.1 , 0.2, 0.1 ,        //blur
                           0.2 ,-0.2, 0.2 ,
                           0.1 , 0.2, 0.1 };          
                  
float[] sobelEdgeDetection = {1, 0, -1,            //sobel kernel edge detection
                              2, 0, -2,
                              1, 0, -1};

void setup() {
  size(1024, 524);
  image = loadImage("moose.jpg");
  intermediary = loadImage("intermediary.jpg");
  image(image, 0, 0);
}

int index(int x, int y) {
  return x + y * image.width;
}

void draw() {
  image.loadPixels();
  intermediary.loadPixels();
  
  kernelConvolution(sobelEdgeDetection);
  //dithering();
  
  intermediary.updatePixels();
  image(intermediary, 512, 0);
}

void kernelConvolution(float[] kernel) {
  if (kernel == sobelEdgeDetection) {
    image.filter(GRAY);
  }
  
  for (int y = 1; y < image.height-1; y++) {
    for (int x = 1; x < image.width-1; x++) {
      
      int index = index(x-1, y-1);
      color c = image.pixels[index];
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      float r = red * kernel[0];
      float g = green * kernel[0];
      float b = blue * kernel[0];

      index = index(x, y-1);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[1];
      g += green * kernel[1];
      b += blue * kernel[1];
      
      index = index(x+1, y-1);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[2];
      g += green * kernel[2];
      b += blue * kernel[2];
      
      index = index(x-1, y);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[3];
      g += green * kernel[3];
      b += blue * kernel[3];   
      
      index = index(x, y);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[4];
      g += green * kernel[4];
      b += blue * kernel[4];

      index = index(x+1, y);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[5];
      g += green * kernel[5];
      b += blue * kernel[5];
      
      index = index(x-1, y+1);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[6];
      g += green * kernel[6];
      b += blue * kernel[6];
      
      index = index(x, y+1);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[7];
      g += green * kernel[7];
      b += blue * kernel[7];
      
      index = index(x+1, y+1);
      c = image.pixels[index];
      red = red(c);
      green = green(c);
      blue = blue(c);
      r += red * kernel[8];
      g += green * kernel[8];
      b += blue * kernel[8];
      
      //r = abs(r);
      //g = abs(g);
      //b = abs(b);
         
      intermediary.pixels[index] = color(r, g, b);
    }
  }
}

void dithering() {  //dithering by Daniel Shiffman
  for (int y = 0; y < image.height-1; y++) {
    for (int x = 1; x < image.width-1; x++) {
      color pix = image.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      int factor = 1;
      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      image.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      //the error diffusion part of error diffusion dithering
      int index = index(x+1, y);
      color c = image.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0;
      g = g + errG * 7/16.0;
      b = b + errB * 7/16.0;
      image.pixels[index] = color(r, g, b);

      index = index(x-1, y+1);
      c = image.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      image.pixels[index] = color(r, g, b);

      index = index(x, y+1);
      c = image.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      image.pixels[index] = color(r, g, b);

      index = index(x+1, y+1);
      c = image.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      image.pixels[index] = color(r, g, b);
    }
  }
}
