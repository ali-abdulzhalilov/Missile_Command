class Explosion extends GameObject{
  float R = 50, r = 5;
  boolean doHit = true;
  
  Explosion(float x, float y) {
    super(x, y);
  }
  
  void update() {
    boomHit();
    if (R > r) {
      r += 1;
    } else
    die = true;
  }
  
  void boomHit() {
    GameScene s = (GameScene)scene;
    for (int i = s.objects.size() - 1; i >= 0; i--) {
      if (s.objects.get(i).getClass() == Missile.class) {
        Missile m = (Missile)s.objects.get(i);
        if (dist(x, y, m.x, m.y) < r/2 && m.sender==1) {
          m.die = true;
          s.objects.add(new Explosion(m.x, m.y));
        }
      }
    }
    
    if (doHit) {
      for (int i=0; i<s.cs.length; i++)
        if (dist(x, y, s.cs[i].x, s.cs[i].y) < r/2) {
          s.cs[i].destroyed = true;
          doHit = false;
        }
    }
  }
  
  void display() {
    noStroke();
    fill(r/R < 0.5 ? palette[3] : (r/R <0.8 ? palette[7] : palette[8]));
    ellipse(x, y, r, r);
  }
}