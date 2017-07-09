class City extends Object{
  float w = 20;
  float h = 10;
  boolean destroyed = false;
  
  City(float x, float y) {
    super(x, y);
  }
  
  void display() {
    noStroke();
    fill(palette[14]);
    rect(x, y-h, w, h);
    
    fill(0);
    textAlign(CENTER, CENTER);
    text(destroyed?"I":"O", x+w/2, y-h/2);
  }
}