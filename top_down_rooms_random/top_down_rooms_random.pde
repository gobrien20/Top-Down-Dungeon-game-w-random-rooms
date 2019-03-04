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
  
  for(int i = 0; i < noOfRooms; i++){
    createRooms();
  }
  //checkRooms();
}

void draw(){
  background(0);
  
  checkCollisions();
  
  for(Projectile projectile: projectiles){
    projectile.update();
    projectile.show();
  }
  
  player.update();
  player.show();
  
  for(Enemy enemy: enemies){
    enemy.update();
    enemy.show();
  }
  
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
    }
  }else if(isMovingy){
    if(pixelsMoved < height){
      for(int i = enemies.size() - 1; i >= 0; i--){
        enemies.remove(i);
      }
      move(xdir, ydir);
    }else{
      timeAfterMove = 0;
      isMovingy = false;
      pixelsMoved = 0;
      for(int i = 0; i < floor(random(5)); i ++){
        enemies.add(new Enemy(xpositions[floor(random(2))], ypositions[floor(random(2))]));
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
  for(Enemy enemy: enemies){
    for(Projectile projectile: projectiles){
      if(((projectile.x - projectile.w * 0.5) > (enemy.x - enemy.w * 0.5) && (projectile.x + projectile.w * 0.5) < (enemy.x + enemy.w * 0.5)) 
        &&(projectile.y - projectile.w * 0.5) > (enemy.y - enemy.w * 0.5) && (projectile.y + projectile.w * 0.5) < (enemy.y + enemy.w * 0.5)){
        enemies.remove(enemy);
        projectiles.remove(projectile);
      }
    }
  }
}
