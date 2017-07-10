class Explosion extends GameObject{
  float max = 50, min = 5;
  float r = 0;
  float sp = 0.01;
  boolean doHit = true;
  
  Explosion(float x, float y) {
    super(x, y);
  }
  
  void update() {
    boomHit();
    r += sp;
    if (r > 1) die = true;
  }
  
  void boomHit() {
    float curR = R();
    GameScene s = (GameScene)scene;
    for (int i = s.objects.size() - 1; i >= 0; i--) {
      if (s.objects.get(i).getClass() == Missile.class) {
        Missile m = (Missile)s.objects.get(i);
        if (dist(x, y, m.x, m.y) < curR/2 && m.sender==1) {
          m.die = true;
          s.objects.add(new Explosion(m.x, m.y));
        }
      }
    }
    
    if (doHit) {
      for (int i=0; i<cs.length; i++)
        if (dist(x, y, cs[i].x, cs[i].y) < curR/2) {
          cs[i].destroyed = true;
          doHit = false;
        }
    }
  }
  
  void display() {
    float curR = R();
    noStroke();
    fill(r < 0.5 ? palette[3] : (r < 0.8 ? palette[7] : palette[8]));
    ellipse(x, y, curR, curR);
  }
  
  float R() {
    return (r < 0.5) ? min + 2*(max-min)*r : min + 2*(max-min)*(1-r);
  }
}