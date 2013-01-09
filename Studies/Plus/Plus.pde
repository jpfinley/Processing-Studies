import processing.pdf.*;

// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480
int videoScale = 8;

// Number of columns and rows in our system
int cols, rows;

// Make some noise
float xnoise = 0.0;
float ynoise = 0.0;
float noiseValue = 0.0;
float inc = 0.9;

void setup() {
  size(640,480);
  noLoop();
  background(255);
  
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;

  beginRecord(PDF, "filename.pdf"); 
}

void draw() {
  
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      
      // Scaling up to draw a rectangle at (x,y)
      int x = i * (videoScale + 16);
      int y = j * (videoScale + 16);
      
      // get a value for the noise and map it to a value
      // for the symbol's transparency
      noiseValue = noise(xnoise, ynoise);
      float alphaChannel = map(noiseValue, 0.0, 1.0, 0, 255);
      fill(104, 95, 88, int(alphaChannel));

      // For every column and row, a rectangle is drawn at
      // an (x,y) location scaled and sized by videoScale.
      if(noiseValue > 0.35 && noiseValue < 0.65){
        if(noiseValue < 0.5){
          // draw a minus
          if(noiseValue < 0.38){
            fill(216, 85, 33, int(alphaChannel));
          }
          noStroke();
          rect(x, y + (videoScale / 2) - 1, videoScale, videoScale / 4);
        }
        else{
          // draw a plus
          if(noiseValue > 0.61){
            fill(216, 85, 33, int(alphaChannel));
          }
          noStroke();
          rect(x, y + (videoScale / 2) - 1, videoScale, videoScale / 4);
          noStroke();
          rect(x + (videoScale / 2) - 1, y, videoScale / 4, videoScale);
        }
      }
      xnoise = xnoise + inc;
    }
    xnoise = 0;
    ynoise = ynoise + inc;
  }
  endRecord();
}

