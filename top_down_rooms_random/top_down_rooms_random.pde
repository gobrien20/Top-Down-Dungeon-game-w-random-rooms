int noOfRooms = 10;
float pixelsMoved = 0;
boolean isMovingx = false;
boolean isMovingy = false;
int xdir, ydir;
float shiftAmount = 10;
Room[][] rooms = new Room[noOfRooms][noOfRooms];
Player player;

void setup(){
  size(640, 480);
  player = new Player(width * 0.5, height * 0.5);
  for(int i = 0; i < noOfRooms; i++){
    createRooms();
  }
  checkRooms();
}

void draw(){
  background(0);
  player.update();
  player.show();
  for(int i = 0; i < noOfRooms; i++){
    for(int j = 0; j < noOfRooms; j++){
      if(rooms[i][j] != null){
        rooms[i][j].checkCollisions();
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
          if(rooms[i][j].left && rooms[i -1][j] == null){
            rooms[i -1][j] = new Room((random(1) < 0.5), true, (random(1) < 0.5), (random(1) < 0.5), i -1, j);
            lim++;
          }
          if(rooms[i][j].right && rooms[i +1][j] == null){
            rooms[i +1][j] = new Room(true, (random(1) < 0.5), (random(1) < 0.5), (random(1) < 0.5), i +1, j);
            lim++;
          }
          if(rooms[i][j].top && rooms[i][j -1] == null){
            rooms[i][j -1] = new Room((random(1) < 0.5), (random(1) < 0.5), (random(1) < 0.5), true, i, j -1);
            lim++;
          }
          if(rooms[i][j].bottom && rooms[i][j +1] == null){
            rooms[i][j +1] = new Room((random(1) < 0.5), (random(1) < 0.5), true, (random(1) < 0.5), i, j + 1);
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
      player.pdir = new PVector(0, -1);
    }else if(keyCode == DOWN){
      player.pdir = new PVector(0, 1);
    }else if(keyCode == LEFT){
      player.pdir = new PVector(-1, 0);
    }else if(keyCode == RIGHT){
      player.pdir = new PVector(1, 0);
    }
  }
}

void keyReleased(){
  player.pdir.mult(0);
}

void move(int xdir, int ydir){
  for(int i = 0; i < noOfRooms; i++){
    for(int j = 0; j < noOfRooms; j++){
      if(rooms[i][j] != null){
        rooms[i][j].xshift += xdir * shiftAmount;
        rooms[i][j].yshift += ydir * shiftAmount;
      }
    }
  }
  pixelsMoved += shiftAmount;
}

void checkRooms(){
  for(int i = 1; i < noOfRooms -1; i++){
    for(int j = 1; j < noOfRooms -1; j++){
      if(rooms[i][j] != null){
        if(rooms[i][j].left && !rooms[i -1][j].right){
          rooms[i -1][j].right = true;
        }else if(rooms[i][j].right && !rooms[i +1][j].left){
          rooms[i +1][j].left = true;
        }else if(rooms[i][j].top && !rooms[i][j -1].bottom){
          rooms[i][j -1].bottom = true;
        }else if(rooms[i][j].bottom && !rooms[i][j +1].top){
          rooms[i][j +1].top = true;
        }
      }
    }
  }
}
