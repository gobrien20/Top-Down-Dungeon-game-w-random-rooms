class Room{
  float gap = 25;
  float w = 20;
  float xsize = width;
  float ysize = height;
  float xshift = 0;
  float yshift = 0;
  boolean left, right, top, bottom;
  int x, y;
  
  Room(boolean left, boolean right, boolean top, boolean bottom, int x, int y){
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
    translate(xpos * xsize - (xsize * 2) + xshift, ypos * ysize - (ysize * 2) + yshift);
    rectMode(CORNERS);
    if(this.left){
      rect(0, 0, w, ysize * 0.5 - gap);
      rect(0, ysize * 0.5 + gap, w, ysize);
    }else{
      rect(0, 0, w, ysize);
    }
    if(this.right){
      rect(xsize - w, 0, xsize, ysize * 0.5 - gap);
      rect(xsize - w, ysize * 0.5 + gap, xsize, ysize);
    }else{
      rect(xsize - w, 0, xsize, ysize);
    }
    if(this.top){
      rect(0, 0, xsize * 0.5 - gap, w);
      rect(xsize *0.5 + gap, 0, xsize, w);
    }else{
      rect(0, 0, xsize, w);
    }
    if(this.bottom){
      rect(0, ysize - w, xsize *0.5 - gap, ysize);
      rect(xsize * 0.5 + gap, ysize -w, xsize, ysize);
    }else{
      rect(0, ysize - w, xsize, ysize);
    }
    popMatrix();
  }
  
  void checkCollisions(){
    if(player.x <= w){
      if (this.left && player.y < (ysize * 0.5) + gap + (player.w * 0.5) && player.y > (ysize * 0.5) - gap - (player.w * 0.5)){
        isMovingx = true;
        xdir = 1;
        ydir = 0;
      }else{
        player.x = w;
      }
    }else if(player.x >= xsize - w - player.w){
      if (this.right && player.y < ysize * 0.5 + gap + (player.w * 0.5) && player.y > ysize * 0.5 - gap - (player.w * 0.5)){
        isMovingx = true;
        xdir = -1;
        ydir = 0;
      }else{
        player.x = xsize - w - player.w;
      }
    }else if(player.y <= w){
      if (this.top && player.x < xsize * 0.5 + gap + (player.w * 0.5) && player.x > xsize * 0.5 - gap - (player.w * 0.5)){
        isMovingy = true;
        xdir = 0;
        ydir = 1;
      }else{
        player.y = w;
      }
    }else if(player.y >= ysize - w - player.w){
      if (this.bottom && player.x < xsize * 0.5 + gap + (player.w * 0.5) && player.x > xsize * 0.5 - gap - (player.w * 0.5)){
        isMovingy = true;
        xdir = 0;
        ydir = -1;
      }else{
        player.y = ysize - w - player.w;
      }
    }
  }
}
