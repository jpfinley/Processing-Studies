PImage sourceImage;  // Declare variable "a" of type PImage

void setup() {
  size(200, 200);
  
  // Grab an image and load its pixels.
  // The image file must be in the data folder of the current sketch.
  // This assumes an image width of an even number.
  sourceImage = loadImage("example.png");
  sourceImage.loadPixels();

  enhanceImage(sourceImage);
}

void enhanceImage(PImage img) {
  // Get the whole number of pixels in the image
  int pixelAmount = sourceImage.width * sourceImage.height;

 // Go through the image
  for (int i = 0; i < pixelAmount; i += 2) { 
    sourceImage.pixels[i] = color(0, 0, 0); 
  }
  
  // Update the image with the new pixel array.
  sourceImage.updatePixels();
}

void draw() {
  image(sourceImage, 0, 0);
}

