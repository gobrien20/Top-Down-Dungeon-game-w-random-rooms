class Room{
  float gap = 2;
  float w = 2;
  float xsize = width /5;
  float ysize = height /5;
  float xshift = 0;
  float yshift = 0;
  boolean left, right, top, bottom;
  float x;
  float y;
  Room(boolean left, boolean right, boolean top, boolean bottom, float x, float y){
    this.left = left;
    this.right = right;
    this.top = top;
    this.bottom = bottom;
    this.x = x;
    this.y = y;
  }
  
  void show(){
    float xpos = x - (noOfRooms * 0.5);
    float ypos = y - (noOfRooms * 0.5);
    pushMatrix();
    fill(255);
    noStroke();
    translate(xpos * xsize - (xsize * 0.5) + xshift, ypos * ysize - (ysize * 0.5) + yshift);
    rectMode(CORNERS);
    if(left){
      rect(0, 0, w, ysize * 0.5 - gap);
      rect(0, ysize * 0.5 + gap, w, ysize);
    }else{
      rect(0, 0, w, ysize);
    }
    if(right){
      rect(xsize - w, 0, xsize, ysize * 0.5 - gap);
      rect(xsize - w, ysize * 0.5 + gap, xsize, ysize);
    }else{
      rect(xsize - w, 0, xsize, ysize);
    }
    if(top){
      rect(0, 0, xsize * 0.5 - gap, w);
      rect(xsize *0.5 + gap, 0, xsize, w);
    }else{
      rect(0, 0, xsize, w);
    }
    if(bottom){
      rect(0, ysize - w, xsize *0.5 - gap, ysize);
      rect(xsize * 0.5 + gap, ysize -w, xsize, ysize);
    }else{
      rect(0, ysize - w, xsize, ysize);
    }
    popMatrix();
  }
}
