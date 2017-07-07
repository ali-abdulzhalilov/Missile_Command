class Base extends Object{
  float w = 50;
  float h = 25;
  
  int missiles = 10;
  
  Base(float x, float y) {
    super(x, y);
    
  }
  
  void shoot() {
    if (missiles>0) {
      GameScene s = (GameScene)scene;
      s.objects.add(new Missile(x+w/2, y-h/2, s.cursorX, s.cursorY, 0));
      missiles--;
    }
  }
  
  boolean mouseOnMe() {
    return (mouseX<x+w && mouseX>x && mouseY>y-h && mouseY<y && mousePressed);
  }
  
  void display() {
    noStroke();
    fill(255, 127, 0);
    quad(x+w/4, y-h,
         x, y,
         x+w, y,
         x+w-w/4, y-h);
         
    fill(0);
    textAlign(CENTER, CENTER);
    text(missiles, x+w/2, y-h/2);
  }
}