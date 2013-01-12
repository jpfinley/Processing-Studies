PImage img;       // The source image
int cellsize = 20; // Dimensions of each cell in the grid, in pixels
int cols, rows;   // Number of columns and rows in our system

// Create a 2D matrix in order to perform a convolution.
// An averae pixel color is achieved by taking the average
// of each color value in the matrix.
// The values in the convolution matrix must add up to 1.
float[][] matrix = { { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } };

int matrixsize = 3;
                     
void setup() {
  size(200, 200, P3D); 
  img  = loadImage("example.png");      // Load the image
  cols = width  / cellsize;             // Calculate # of columns
  rows = height / cellsize;             // Calculate # of rows
}

void draw() {
  background(0);
  loadPixels();
  
  // Begin loop for columns of cells
  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows of cells
    for ( int j = 0; j < rows; j++) {
      // Get the coordinate for the center of the cell area
      int x = i * cellsize + cellsize / 2;
      int y = j * cellsize + cellsize / 2;
      int loc = x + y * width;             // Pixel array location
//      color c = img.pixels[loc];           // Grab the color
      
      // Each pixel location (x, y) gets passed into a function
      // called convolution() which returns a new color value to be displayed.
      color c = convolution(x, y, matrix, matrixsize, img);
      
      // Calculate a z position as a function of mouseX and pixel brightness
//      float z = (mouseX / (float)width) * brightness(img.pixels[loc]) - 100.0;
      
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x, y, 0);
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
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
    }
  }
  
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
