class Enemy{
  float x, y;
  float w = 20;
  PVector movement = new PVector(0, 0);
  boolean exists = true;
  
  Enemy(float x, float y){
    this.x = x;
    this.y = y;
    movement = getMovement();
  }
  
  void show(){
    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    rectMode(CENTER);
    rect(x, y, w, w);
    popMatrix();
  }
  
  void update(){
    if(frameCount % 30 == 0){
      movement = getMovement();
    }
    
    walk(movement);
  }
  
  void walk(PVector move){
    x += move.x * 3;
    y += move.y * 3;
  }
  
  PVector getMovement(){
    int dir_x, dir_y;
    
    if(dist(x, y, 0, 0) < dist(x, y, width, 0) && dist(x, y, 0, 0) < dist(x, y, 0, height)){
      dir_x = round(random(0, 1));
      dir_y = round(random(0, 1));
    }else if(dist(x, y, 0, 0) < dist(x, y, width, 0) && dist(x, y, 0, 0) > dist(x, y, 0, height)){
      dir_x = round(random(0, 1));
      dir_y = round(random(-1, 0));
    }else if(dist(x, y, 0, 0) > dist(x, y, width, height) && dist(x, y, 0, 0) < dist(x, y, width, height)){
      dir_x = round(random(-1, 0));
      dir_y = round(random(0, 1));
    }else{
      dir_x = round(random(-1, 0));
      dir_y = round(random(-1, 0));
    }
    
    if(dir_x != 0){
      dir_y = 0;
    }else{
      dir_x = 0;
    }
    
    return new  PVector(dir_x, dir_y);
  }
  
  void checkProjectiles(){
    for(int j = projectiles.size() -1; j >= 0; j--){
      if(((projectiles.get(j).x - projectiles.get(j).w * 0.5) >= (this.x - this.w * 0.5) && (projectiles.get(j).x + projectiles.get(j).w * 0.5) <= (this.x + this.w * 0.5)) 
        &&(projectiles.get(j).y - projectiles.get(j).w * 0.5) >= (this.y - this.w * 0.5) && (projectiles.get(j).y + projectiles.get(j).w * 0.5) <= (this.y + this.w * 0.5)){
        projectiles.remove(j);
        exists = false;
      }
    }
  }
}
