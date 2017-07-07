class City extends Object{
  float w = 20;
  float h = 10;
  int lives = 3;
  
  City(float x, float y) {
    super(x, y);
  }
  
  void takeDamage() {
    if (!isDestroyed()) lives--;
  }
  
  boolean isDestroyed() {return lives <= 0;}
  
  void display() {
    noStroke();
    fill(255, 200, 150);
    rect(x, y-h, w, h);
    
    fill(0);
    textAlign(CENTER, CENTER);
    text(lives, x+w/2, y-h/2);
  }
}