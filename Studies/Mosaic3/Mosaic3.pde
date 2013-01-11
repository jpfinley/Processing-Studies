PImage img;       // The source image
int cellsize = 20; // Dimensions of each cell in the grid, in pixels
int cols, rows;   // Number of columns and rows in our system

// Create a 2D matrix in order to perform a convolution.
// An averae pixel color is achieved by taking the average
// of each color value in the matrix.
// The values in the convolution matrix must add up to 1.
float[][] matrix = { { 1/9, 1/9, 1/9 },
                     { 1/9, 1/9, 1/9 },
                     { 1/9, 1/9, 1/9 } };
int matrixsize = 3;
                     
void setup() {
  size(200, 200, P3D); 
  img  = loadImage("example.png");      // Load the image
  noLoop();
}

void draw() {
  background(0);
  loadPixels();
  
         // Pixel array location
      color c = img.pixels[6030];           // Grab the color
      
      // Each pixel location (x, y) gets passed into a function
      // called convolution() which returns a new color value to be displayed.
      color convo = convolution(30, 30, matrix, matrixsize, img);
      
      println("pixel color is " + red(c) + " " + blue(c) + " " + green(c));
      println("convo color is " + red(convo) + " " + blue(convo) + " " + green(convo));
      println("convo color is " + hex(convo));
}


color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  
  // Loop through convolution matrix
  for (int i = 0; i < matrixsize; i++){
    for (int j = 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + img.width * yloc;
      
      // Make sure we have not walked off the edge of the pixel array
      loc = constrain(loc, 0, img.pixels.length - 1);
      
      // Calculate the convolution
      // We sum all the neighboring pixels multiplied by
      // the values in the convolution matrix.
      rtotal += (red(img.pixels[loc])   * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc])  * matrix[i][j]);
      println("totals are " + rtotal + " " + gtotal + " " + btotal);
    }
  }
  
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
