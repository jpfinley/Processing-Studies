// Draws a map-like image with islands sorrunded by water.

float increment = 0.008;

void setup() {
  size(400,250);
  noLoop();
}

void draw() {
  background(0);
  
  // Optional: adjust noise detail here
   noiseDetail(8,0.65f);
  
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff)*255;

      // Try using this line instead
      //float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
      if(bright < 200 && bright > 50){
        pixels[x+y*width] = color(bright);
      }
      else{
        pixels[x+y*width] = color(65, 105, 255);
      }
    }
  }
  
  updatePixels();
//  save("diagonal.tif");
}

