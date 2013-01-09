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
float inc = 0.02;

void setup() {
  size(640,480);
  noLoop();
  noStroke();
  background(255);
  
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
}

void draw() {
  
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      
      // Scaling up to draw a rectangle at (x,y)
      int x = i * (videoScale + 20);
      int y = j * (videoScale + 20);
      noiseValue = noise(xnoise, ynoise);

      // For every column and row, a rectangle is drawn at
      // an (x,y) location scaled and sized by videoScale.
        if(int(noiseValue * 100) % 2 == 0){
          createRect(x, y, #6A5E58);
        }
        else{
          createRect(x, y, #2A8E82);
        }
     
      xnoise = xnoise + inc;
    }
    xnoise = 0;
    ynoise = ynoise + inc;
  }
}

void createRect(int xPosition, int yPosition, color fillColor){
  fill(fillColor);
  int rectWidth  = int(random(5, 25));
  int rectHeight = 100 - (2 * rectWidth); // y = a-bx, an inverse relationship
  rect(xPosition + random(-15, 15), yPosition, rectWidth, rectHeight);
}

