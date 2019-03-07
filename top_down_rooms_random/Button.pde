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
    text(text, x + 50, y + 25);
    popMatrix();
  }
}
