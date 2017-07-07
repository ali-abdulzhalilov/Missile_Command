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
    strokeWeight(2);
    for (int i = 0; i < trail.length-1; i++){
      float k = (i/float(trail.length));
      if (sender==0)
        stroke(255,127*k,0, 255*(1-k));
      else
        stroke(0,127*k,255, 255*(1-k));
      line(trail[i].x, trail[i].y, trail[i+1].x, trail[i+1].y);
    }
  }
}