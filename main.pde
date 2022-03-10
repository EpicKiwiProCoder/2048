ArrayList<square> squares = new ArrayList<square>();
ArrayList<square> toRemove = new ArrayList<square>();
int score, value, x, y = 0;
class square{
  int x,y,value = 0;
  square(int x, int y, int value) {
    this.x = x;
    this.y = y;
    this.value = value;
  }
  void move(int xOffset, int yOffset) {
    boolean blocked = false;
    while (!blocked) {
      for (square s : squares) {
        if (s.x == this.x+xOffset && s.y == this.y+yOffset) {
          if (s.value == this.value) {
            toRemove.add(s);
            this.x += xOffset;
            this.y += yOffset;
            this.value *= 2;
            score += this.value;
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
      }
    }
  }
}
void addRandom() {
  while (true) {
    if (squares.size() == 17) {println("Game Over");return;}
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
        fill(200); //blank square
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
  
  if (keyCode == UP) {
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < 4; x++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            s.move(0, -1);
            
          }
        }
        
      } 
    }
    addRandom();
  } else if (keyCode == DOWN) {
    for (int y = 3; y >= 0; y--) {
      for (int x = 0; x < 4; x++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            s.move(0, 1);
          }
        }
        
      } 
    }
    addRandom();
  } 
  else if (keyCode == LEFT) {
    for (int x = 0; x < 4; x++) {
      for (int y = 0; y < 4; y++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            s.move(-1, 0);
          }
        }
      } 
    }
    addRandom();
  }
  else if (keyCode == RIGHT) {
    for (int x = 3; x >= 0; x--) {
      for (int y = 0; y < 4; y++) {
        for (square s : squares) {
          if (s.x == x && s.y == y) {
            s.move(1, 0);
          }
        }      
      } 
    }
    addRandom();
  }
  for (square s : toRemove) {
    squares.remove(s);
  }
}

int xSquare, ySquare = 0;

void draw() {
  fill(100);
  noStroke();
  background(150);
  textSize(80);
  stroke(255);
  textAlign(LEFT, TOP);
  text(score, 20, 20);
  drawSquares();
}
