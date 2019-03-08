class Item{
  float x, y;
  float w = 10;
  boolean exists = true;
  
  Item(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
    noStroke();
    fill(0, 255, 0);
    pushMatrix();
    rectMode(CENTER);
    rect(x, y, w, w);
    popMatrix();
  }
  
  void update(){
    checkCollisions();
  }
  
  void checkCollisions(){
    if(x - (w * 0.5) >= player.x - (player.w * 0.5) && x + (w * 0.5) <= player.x + (player.w * 0.5)
    && y - (w * 0.5) >= player.y - (player.w * 0.5) && y + (w * 0.5) <= player.y + (player.w * 0.5)){
       exists = false;
       player.strength = 50;
       player.deltaTime = 5;
    }
  }
}
