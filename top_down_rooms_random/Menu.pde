class Menu{
  String heading;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  Menu(String heading){
    this.heading = heading;
    if(heading == "Start"){
      buttons.add(new Button(220, 75, "New Game"));
      buttons.add(new Button(220, 175, "Load Game"));
    }else if(heading == "Paused"){
      buttons.add(new Button(220, 75, "Continue"));
      buttons.add(new Button(220, 175, "New Game"));
      buttons.add(new Button(220, 275, "Save Game"));
      buttons.add(new Button(220, 375, "Quit"));
    }
  }
  
  void show(){
    textSize(32);
    fill(200);
    textAlign(CENTER);
    text(heading, width * 0.5, 50);
    for(Button button: buttons){
      button.show();
    }
  }
}
