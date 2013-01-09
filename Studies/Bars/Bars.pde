import processing.pdf.*;

void setup() {
  size(600, 100);
  noStroke();
  noLoop();
  beginRecord(PDF, "filename.pdf"); 
}

void draw() {
  float v = 0.0;
  float inc = 0.1;
  fill(0);
  noiseSeed(0);
  for (int i = 0; i < width; i = i+4) {
    float n = noise(v) * 70.0;
    rect(i + random(-2, 2), 10 + n, 3, 200);
    v = v + inc;
  }

  endRecord();
}

