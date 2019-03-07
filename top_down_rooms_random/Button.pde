class Button{
  float x, y;
  float w = 200;
  float h = 75;
  String text;
  boolean clicked = false;
  
  Button(float x, float y, String text){
    this.x = x;
    this.y = y;
    this.text = text;
  }
  
  void show(){
    pushMatrix();
    fill(200);
    rectMode(CORNER);
    rect(x, y, w, h);
    textSize(26);
    fill(255);
    textAlign(CENTER);
    text(text, width * 0.5, y + 45);
    popMatrix();
  }
}
