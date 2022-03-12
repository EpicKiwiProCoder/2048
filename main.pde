ArrayList<square> squares = new ArrayList<square>();
ArrayList<square> toRemove = new ArrayList<square>();
int score, value, x, y = 0;
class square{
  int x,y,value = 0;
  boolean merged, removed = false;
  square(int x, int y, int value) {
    this.x = x;
    this.y = y;
    this.value = value;
  }
  boolean move(int xOffset, int yOffset) {
    boolean blocked = false;
    boolean moved = false;
    while (!blocked) {
      for (square s : squares) {
        if (s.x == this.x+xOffset && s.y == this.y+yOffset) {
          // s is square in front
          if (s.value == this.value && !s.merged && !this.merged && !s.removed) {
            //should merge
            merged = true;
            s.removed = true;
            toRemove.add(s); //here 
            this.x += xOffset;
            this.y += yOffset;
            this.value *= 2;
            score += this.value;
            moved = true;
          }
          blocked = true;
        }
      }
      
      
      if (this.y+yOffset == 4 || this.y+yOffset == -1) {
        blocked = true;
      }
      if (this.x+xOffset == 4 || this.x+xOffset == -1) {
        blocked = true;
      }
      if (!blocked) {
        this.x += xOffset;
        this.y += yOffset;
        moved = true;
      }
    }
    return moved;
  }
}
void addRandom() {
  while (true) {
    if (squares.size() == 16) {println("Game Over");return;}
    x = int(random(4));
    y = int(random(4));
    boolean duplicate = false;
    for (square s : squares) {
      if (s.x == x && s.y == y) {
        duplicate = true;
      }
    }
    if (!duplicate) {break;}
    
  }
  if (random(1) > 0.85) {value = 4;} 
  else {value = 2;}
  squares.add(new square(x,y,value));
}
void drawSquares() {
  noStroke();
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {
        xSquare = x*100+20*(x+1);
        ySquare = y*100+20*(y+1)+120;
        fill(205,193,180); //blank square
        rect(xSquare, ySquare, 100, 100, 8);
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            //there is a square at that location
            fill(255, 120, 31);
            rect(xSquare, ySquare, 100, 100, 8);
            textAlign(CENTER, CENTER);
            fill(255);
            textSize(44);
            text(s.value, xSquare+50, ySquare+45);
          }
        }
    }
  }
}

void setup() {
  size(500, 620);
  addRandom();
  addRandom();
  
}
void keyPressed() {
  boolean moved = false;
  
  if (keyCode == UP) {
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < 4; x++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            if(s.move(0, -1) == true) {moved=true;}
            
          }
        }
        
      } 
    }
  } else if (keyCode == DOWN) {
    for (int y = 3; y >= 0; y--) {
      for (int x = 0; x < 4; x++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            if(s.move(0, 1) == true) {moved=true;}
          }
        }
        
      } 
    }
  } 
  else if (keyCode == LEFT) {
    for (int x = 0; x < 4; x++) {
      for (int y = 0; y < 4; y++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            if(s.move(-1, 0) == true) {moved=true;}
          }
        }
      } 
    }
  }
  else if (keyCode == RIGHT) {
    for (int x = 3; x >= 0; x--) {
      for (int y = 0; y < 4; y++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            
            if(s.move(1, 0) == true) {moved=true;}
          }
        }      
      } 
    }
  }
  if(moved){addRandom();}
  for (square s : toRemove) {
    squares.remove(s);
  }
  for (square s : squares) {
    s.merged = false;
  }
}

int xSquare, ySquare = 0;

void draw() {
  fill(75);
  noStroke();
  background(187,173,160);
  textSize(80);
  stroke(255);
  textAlign(LEFT, TOP);
  text(score, 20, 20);
  drawSquares();
}
