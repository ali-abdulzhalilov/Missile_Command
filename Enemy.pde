class Enemy extends Object{
  float ot, fireRate = 1, fireTimer;
  
  Enemy() {
    super(0, 0);
    ot = millis();
    fireTimer = fireRate;
  }
  
  void update() {
    shoot();
    
    fireTimer -= (millis() - ot) / 1000;
    ot = millis();
  }
  
  void shoot() {
    if (fireTimer<=0) {
      GameScene s = (GameScene)scene;
      s.objects.add(new Missile(random(width), 0, random(width), height, 1));
      
      fireTimer = fireRate;
    }
  }
}