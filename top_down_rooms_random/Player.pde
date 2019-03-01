class Player{
  float x, y;
  float w = 20;
  PVector pdir = new PVector(0, 0);
  
  Player(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
    noStroke();
    fill(200, 0, 250);
    pushMatrix();
    rectMode(CORNER);
    rect(x, y, w, w);
    popMatrix();
  }
  
  void update(){
    walk();
    if(isMovingx || isMovingy){
      doorShift();
    }
  }
  
  void walk(){
    x += pdir.x * 3;
    y += pdir.y * 3;
  }
  
  void doorShift(){
    if(isMovingx){
      if(xdir > 0){
        x += shiftAmount;
      }else{
        x -= shiftAmount;
      }
    }else if(isMovingy){
     if(ydir > 0){
        y += shiftAmount;
      }else{
        y -= shiftAmount;
      }
    }
  }
}
