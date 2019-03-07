class Menu{
  String heading;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  Menu(String heading){
    this.heading = heading;
    if(heading == "Start"){
      buttons.add(new Button(140, 100, "New Game"));
      buttons.add(new Button(140, 200, "Load Game"));
    }else if(heading == "Paused"){
      buttons.add(new Button(140, 100, "Continue"));
      buttons.add(new Button(140, 200, "New Game"));
      buttons.add(new Button(140, 300, "Save Game"));
      buttons.add(new Button(140, 400, "Quit"));
    }
  }
  
  void show(){
    textSize(32);
    fill(200);
    text(heading, 200, 50);
    for(Button button: buttons){
      button.show();
    }
  }
}
