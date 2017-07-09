class Trail extends GameObject{
  PVector[] trail;
  Missile owner;
  int sender;
  
  Trail(float x, float y, Missile owner, int n) {
    super(0, 0);
    this.owner = owner;
    this.sender = owner.sender;
    this.die = false;
    
    this.trail = new PVector[n];
    for (int i = 0; i < trail.length; i++)
      trail[i] = new PVector(x, y);
  }
  
  void update() {
    for (int i = trail.length - 2; i >= 0; i--){
      trail[i+1].x = trail[i].x;
      trail[i+1].y = trail[i].y;
    }
    trail[0].x = owner.x;
    trail[0].y = owner.y;
    
    if (dist(trail[0].x, trail[0].y, trail[trail.length-1].x, trail[trail.length-1].y) < 1 && owner.die)  {
      die = true;
    }
  }
  
  void display() {
    noStroke();
    for (int i = trail.length - 1; i >= 0; i--){
      float r = i/float(trail.length);
      float size = 2 + 10*r;
      if (trail[i].x!=trail[0].x&&trail[i].y!=trail[0].y) {
        if (sender == 0)
          fill(palette[7], r*127);
        else
          fill(palette[13], r*127);
      } else fill(0, 0);
      ellipse(trail[i].x, trail[i].y, size, size);
    }
  }
}