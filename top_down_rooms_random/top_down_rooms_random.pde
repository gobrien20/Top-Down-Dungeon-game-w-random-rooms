Menu startMenu = new Menu();
boolean newGame = true;

Menu pauseMenu = new Menu();
boolean paused = false;

int noOfRooms = 10;
float pixelsMoved = 0;

boolean isMovingx = false;
boolean isMovingy = false;

int xdir, ydir;

float shiftAmount = 10;
int timeAfterMove = 60;

Room[][] rooms = new Room[noOfRooms][noOfRooms];
Player player;

ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Item> items = new ArrayList<Item>();

float xpositions[] = new float[2];
float ypositions[] = new float[2];

void setup(){
  size(640, 480);
  player = new Player(width * 0.5, height * 0.5);
  xpositions[0] = 50;
  xpositions[1] = width - 50;
  ypositions[0] = 50;
  ypositions[1] = height - 50;
  
  for(int i = 0; i < floor(random(5, 10)); i ++){
    enemies.add(new Enemy(xpositions[floor(random(2))], ypositions[floor(random(2))]));
  }
  
  for(int i = 0; i < floor(random(5, 10)); i++){
    float offset = random(-10, 10);
    items.add(new Item(xpositions[floor(random(2))] + offset, ypositions[floor(random(2))] + offset));
  }
  
  for(int i = 0; i < noOfRooms; i++){
    createRooms();
  }
  //checkRooms();
}

void draw(){
  background(0);
  
  if(paused){
    if(newGame){
      startMenu.update();
      startMenu.show();
    }else{
      pauseMenu.update();
      pauseMenu.show();
    }
  }else{
    checkMovement();
    checkCollisions();
    updateProjectiles();
    player.update();
    player.show();
    updateEnemies();
    updateRooms();
  }
}

void updateProjectiles(){
  for(Projectile projectile: projectiles){
    projectile.update();
    projectile.show();
  }
}

void updateEnemies(){
  for(int i = enemies.size() -1; i >= 0; i--){
    enemies.get(i).update();
    if(enemies.get(i).exists){
      enemies.get(i).show();
    }else{
      enemies.remove(i);
    }
  }
}

void updateItems(){
  for(int i = items.size() - 1; i >= 0; i++){
    items.get(i).update();
    if(items.get(i).exists){
      items.get(i).show();
    }else{
      items.remove(i);
    }
  }
}

void updateRooms(){
  for(int i = 0; i < noOfRooms; i++){
    for(int j = 0; j < noOfRooms; j++){
      if(rooms[i][j] != null){
        if((!isMovingx || !isMovingy) && timeAfterMove >= 60){
          rooms[i][j].checkCollisions();
        }
        rooms[i][j].show();
      }
    }
  }
}

void checkMovement(){
  if(isMovingx){
    if(pixelsMoved < width){
      for(int i = enemies.size() - 1; i >= 0; i--){
        enemies.remove(i);
      }
      move(xdir, ydir);
    }else{
      timeAfterMove = 0;
      isMovingx = false;
      pixelsMoved = 0;
      for(int i = 0; i < floor(random(5)); i ++){
        enemies.add(new Enemy(xpositions[floor(random(2))], ypositions[floor(random(2))]));
      }
      for(int i = 0; i < floor(random(5)); i ++){
        items.add(new Item(xpositions[floor(random(2))], ypositions[floor(random(2))]));
      }
    }
  }else if(isMovingy){
    if(pixelsMoved < height){
      for(int i = enemies.size() - 1; i >= 0; i--){
        enemies.remove(i);
      }
      for(int i = items.size() - 1; i >= 0; i--){
        items.remove(i);
      }
      move(xdir, ydir);
    }else{
      timeAfterMove = 0;
      isMovingy = false;
      pixelsMoved = 0;
      for(int i = 0; i < floor(random(5)); i ++){
        enemies.add(new Enemy(xpositions[floor(random(2))], ypositions[floor(random(2))]));
      }
      for(int i = items.size() - 1; i >= 0; i--){
        items.remove(i);
      }
    }
  }
  
  timeAfterMove++;
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
      player.dir = new PVector(0, -1);
    }else if(keyCode == DOWN){
      player.pdir = new PVector(0, 1);
      player.dir = new PVector(0, 1);
    }else if(keyCode == LEFT){
      player.pdir = new PVector(-1, 0);
      player.dir = new PVector(-1, 0);
    }else if(keyCode == RIGHT){
      player.pdir = new PVector(1, 0);
      player.dir = new PVector(1, 0);
    }
  }
  if(key == ' '){
    projectiles.add(new Projectile(player.x, player.y, player.pdir));
  }else if(key == 'p' || key == 'P'){
    if(paused){
      paused = false;
    }else{
      paused = true;
    }
  }
}

void keyReleased(){
  if(key != ' '){
    player.dir.mult(0);
  }
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
  for(Room[] column: rooms){
    for(Room room: column){
      if(room != null){
        if(room.left && rooms[room.x -1][room.y] != null && !rooms[room.x -1][room.y].right){
          rooms[room.x -1][room.y].right = true;
        }else if(room.right && rooms[room.x +1][room.y] != null && !rooms[room.x +1][room.y].left){
          rooms[room.x +1][room.y].left = true;
        }else if(room.top && rooms[room.x][room.y -1] != null && !rooms[room.x][room.y -1].bottom){
          rooms[room.x][room.y -1].bottom = true;
        }else if(room.bottom && rooms[room.x][room.y +1] != null && !rooms[room.x][room.y +1].top){
          rooms[room.x][room.y +1].top = true;
        }
      }
    }
  }
}

void checkCollisions(){
  for(int i = enemies.size() -1; i >= 0; i--){
    if(!enemies.get(i).exists){
      enemies.get(i).checkProjectiles();
    }
  }
}
