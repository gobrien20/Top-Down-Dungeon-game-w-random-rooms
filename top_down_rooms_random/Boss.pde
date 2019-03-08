class Boss{
  float x, y;
  float w = 50;
  PVector movement = new PVector(0, 0);
  boolean exists = true;
  float life = 1000;
  
  Boss(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
    noStroke();
    float alpha = map(life, 0, 100, 0, 255);
    fill(255, 0, 0, alpha);
    pushMatrix();
    rectMode(CENTER);
    rect(x, y, w, w);
    popMatrix();
  }
  
  void update(){
    
  }

  void checkProjectiles(){
    for(int j = projectiles.size() -1; j >= 0; j--){
      if(((projectiles.get(j).x - projectiles.get(j).w * 0.5) >= (this.x - this.w * 0.5) && (projectiles.get(j).x + projectiles.get(j).w * 0.5) <= (this.x + this.w * 0.5)) 
        &&(projectiles.get(j).y - projectiles.get(j).w * 0.5) >= (this.y - this.w * 0.5) && (projectiles.get(j).y + projectiles.get(j).w * 0.5) <= (this.y + this.w * 0.5)){
        projectiles.remove(j);
        life -= player.strength;
        if(life <= 0){
          exists = false;
        }
      }
    }
  }
  
  void checkPlayer(Player player){
    if(player.x - (player.w * 0.5) >= this.x - (this.w * 0.5) && player.x + (player.w * 0.5) <= this.x + (this.w *0.5) 
    && player.y - (player.w * 0.5) >= this.y - (this.w * 0.5) && player.y + (player.w * 0.5) <= this.y + (this.w * 0.5)){
      player.lives--;
    }
  }
}
