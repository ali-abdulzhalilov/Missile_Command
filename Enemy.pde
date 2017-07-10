class Enemy extends Object{
  int waveCount;
  int missilesPerWave = 5;
  float fireRate = 10-level*1;
  Timer fireTimer;
  ArrayList<PVector> targets;
  
  Enemy(int wCount, int mPerWave) {
    super(0, 0);
    waveCount = wCount;
    missilesPerWave = mPerWave;
    fireTimer = new Timer();
    fireTimer.start(fireRate);
    
    targets = new ArrayList<PVector>();
  }
  
  void update() {
    //if (targets.size() == 0) {
    //  findTargets(2, 5);
    //}
    
    if (fireTimer.currentTime()>=fireRate && waveCount>=0) {
      newWave();
      fireTimer.restart();
    }
  }
  
  void findTargets(int baseCount, int cityCount) {
    GameScene s = (GameScene)scene; 
    baseCount = baseCount<0 ? 0 : (baseCount>s.bs.length ? s.bs.length : baseCount); // check and fix
    cityCount = cityCount<0 ? 0 : (cityCount>  cs.length ?   cs.length : cityCount); // possible overflows
    
    print(level + " c:");
    boolean[] inTargets = new boolean[cs.length]; for (int i=0; i<inTargets.length; i++) inTargets[i]=false;
    while (targets.size() < cityCount) {
      int r = floor(random(cs.length));
      if (!inTargets[r]) {
        inTargets[r] = true;
        targets.add(new PVector(cs[r].x+cs[r].w/2, cs[r].y+cs[r].h/2));
        print(r);
      }
    }
    
    print(" b:");
    inTargets = new boolean[s.bs.length]; for (int i=0; i<inTargets.length; i++) inTargets[i]=false;
    while (targets.size() < cityCount+baseCount) {
      int r = floor(random(s.bs.length));
      if (!inTargets[r]) {
        inTargets[r] = true;
        targets.add(new PVector(s.bs[r].x+s.bs[r].w/2, s.bs[r].y+s.bs[r].h/2));
        print(r);
      }
    }
    
    println();
  }
  
  void newWave() {
    findTargets(2, 5);
    for (int i=0; i<missilesPerWave; i++) {
      GameScene s = (GameScene)scene;
      int t =  floor(random(targets.size()));
      s.objects.add(new Missile(random(width), -5-random(200), targets.get(t).x, targets.get(t).y, 1));
    }
    waveCount--;
  }
}