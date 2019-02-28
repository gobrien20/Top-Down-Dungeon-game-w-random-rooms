int noOfRooms = 5;
float pixelsMoved = 0;
boolean isMovingx = false;
boolean isMovingy = false;
int xdir, ydir;
Room[][] rooms = new Room[noOfRooms][noOfRooms];

void setup(){
  size(640, 480);
  createRooms();
}

void draw(){
  background(0);
  for(int i = 0; i < noOfRooms; i++){
    for(int j = 0; j < noOfRooms; j++){
      if(rooms[i][j] != null){
        rooms[i][j].show();
      }
    }
  }
  if(isMovingx){
    if(pixelsMoved < width){
      move(xdir, ydir);
    }else{
      isMovingx = false;
      pixelsMoved = 0;
    }
  }else if(isMovingy){
    if(pixelsMoved < height){
      move(xdir, ydir);
    }else{
      isMovingy = false;
      pixelsMoved = 0;
    }
  }
}

void createRooms(){
  int lim = 0;
  if(rooms[ceil(noOfRooms * 0.5)][ceil(noOfRooms * 0.5)] == null){
    rooms[ceil(noOfRooms * 0.5)][ceil(noOfRooms * 0.5)] = new Room(true, true, true, true, ceil(noOfRooms * 0.5), ceil(noOfRooms * 0.5));
    lim++;
  }else{
    for(int i = 1; i < noOfRooms -1; i++){
      for(int j = 1; j < noOfRooms -1; j++){
        if(rooms[i][j] != null && lim <= noOfRooms){
          if(rooms[i][j].left && rooms[i][j -1] == null){
            rooms[i -1][j] = new Room((random(1) < 0.5), true, (random(1) < 0.5), (random(1) < 0.5), i -1, j);
            lim++;
          }
          if(rooms[i][j].right && rooms[i][j +1] == null){
            rooms[i -1][j] = new Room(true, (random(1) < 0.5), (random(1) < 0.5), (random(1) < 0.5), i +1, j);
            lim++;
          }
          if(rooms[i][j].top && rooms[i -1][j] == null){
            rooms[i -1][j] = new Room((random(1) < 0.5), (random(1) < 0.5), (random(1) < 0.5), true, i, j -1);
            lim++;
          }
          if(rooms[i][j].bottom && rooms[i +1][j] == null){
            rooms[i -1][j] = new Room((random(1) < 0.5), (random(1) < 0.5), true, (random(1) < 0.5), i, j + 1);
            lim++;
          }
        }
      }
    }
  }
}

void keyPressed(){
  if(isMovingx || isMovingy){
  }else{
    if(keyCode == UP){
      isMovingy = true;
      xdir = 0;
      ydir = -1;
    }else if(keyCode == DOWN){
      isMovingy = true;
      xdir = 0;
      ydir = 1;
    }else if(keyCode == LEFT){
      isMovingx = true;
      xdir = -1;
      ydir = 0;
    }else if(keyCode == RIGHT){
      isMovingx = true;
      xdir = 1;
      ydir = 0;
    }
  }
}

void move(int xdir, int ydir){
  for(int i = 0; i < noOfRooms; i++){
    for(int j = 0; j < noOfRooms; j++){
      if(rooms[i][j] != null){
        rooms[i][j].xshift += xdir * 10;
        rooms[i][j].yshift += ydir * 10;
      }
    }
  }
  pixelsMoved += 10;
}
