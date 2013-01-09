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
  size(640, 480);
  smooth();
  noLoop();
  noStroke();
  background(255);
  fill(#2A8E82);
  rectMode(CENTER);
  
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Scaling up to draw a rectangle at (x,y)
      int x = i * (videoScale + 0);
      int y = j * (videoScale + 0);
      drawRect(x, y);
    }
}

void drawRect(int x, int y){
  int rectWidth  = int(random(1, 20));
  int rectHeight = 100 - (2 * rectWidth); // y = a-bx, an inverse relationship
  rect(x, y, rectWidth, rectHeight);
}
