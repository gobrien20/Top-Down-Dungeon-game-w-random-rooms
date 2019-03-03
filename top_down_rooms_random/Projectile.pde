class Projectile{
  float x, y;
  float w = 5;
  PVector direction;
  
  Projectile(float x, float y, PVector direction){
    this.x = x;
    this.y = y;
    this.direction = direction;
  }
  
  void show(){
    noStroke();
    fill(10, 10, 250);
    ellipse(x, y, w, w);
  }
  
  void update(){
    x += direction.x * 7;
    y += direction.y * 7;
  }
  
}
