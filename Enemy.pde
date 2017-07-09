class Enemy extends Object{
  int waveCount;
  int missilesPerWave = 5;
  float ot, fireRate = 10-level*1, fireTimer = 0;
  ArrayList<PVector> targets;
  
  Enemy(int waveCount, int missilesPerWave) {
    super(0, 0);
    this.waveCount = waveCount;
    this.missilesPerWave = missilesPerWave;
    this.ot = millis();
    
    targets = new ArrayList<PVector>();
  }
  
  void update() {
    if (targets.size() == 0) {
      GameScene s = (GameScene)scene;
      boolean[] inTargets = new boolean[cs.length];
      for (int i=0; i<inTargets.length; i++) inTargets[i]=false;
      while (targets.size() < 5) {
        int r = floor(random(cs.length));
        if (!inTargets[r]) {
          inTargets[r] = true;
          targets.add(new PVector(cs[r].x+cs[r].w/2, cs[r].y+cs[r].h/2));
          println(r);
        }
      }
      targets.add(new PVector(s.bs[0].x+s.bs[0].w/2, s.bs[0].y+s.bs[0].h/2));
      targets.add(new PVector(s.bs[1].x+s.bs[1].w/2, s.bs[1].y+s.bs[1].h/2));
      targets.add(new PVector(s.bs[2].x+s.bs[2].w/2, s.bs[2].y+s.bs[2].h/2));
    }
    
    if (fireTimer<=0 && waveCount>=0) {
      newWave();
      fireTimer = fireRate;
    }
    
    fireTimer -= (millis() - ot) / 1000;
    ot = millis();
  }
  
  void newWave() {
    for (int i=0; i<missilesPerWave; i++) {
      GameScene s = (GameScene)scene;
      int t =  floor(random(targets.size()));
      s.objects.add(new Missile(random(width), -5-random(200), targets.get(t).x, targets.get(t).y, 1));
    }
    waveCount--;
  }
}