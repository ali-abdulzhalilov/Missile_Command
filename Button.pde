interface ButtonCallback {
  void execute();
}

abstract class BaseButtonCallback implements ButtonCallback{
}

class Button {
  float x, y;
  float w, h;
  ButtonCallback bc;
  String text;
  int state = 0; //0-idle, 1-hover, 2-press
  
  Button(float x, float y, float w, float h, String text, ButtonCallback bc) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.bc = bc;
  }
  
  void input() {
    if (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h) // if mouse over this button
      if (mousePressed) { // is this button pressed
        state = 2;
        bc.execute();
      } else state = 1;
    else state = 0;
  }
  
  void display() {
    noStroke();
    switch (state) {
      case 0: fill(255, 20); break;
      case 1: fill(255, 50); break;
      case 2: fill(255, 100); break;
    }
    rect(x, y, w, h);
    
    fill(255);
    textAlign(CENTER,CENTER);
    text(text, x+w/2, y+h/2);
  }
}