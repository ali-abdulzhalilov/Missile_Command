class Missile extends GameObject{
  float tx, ty; // target pos
  float sx, sy; // start pos
  float sp = 1; // speed
  int sender; // 0-base, 1-enemy
  
  Missile(float x, float y, float tx, float ty, int sender) {
    super(x, y);
    this.tx = tx;
    this.ty = ty;
    this.sx = x;
    this.sy = y;
    this.sender = sender;
    this.sp *= sender==0 ? 4 : 1;
    
    GameScene s = (GameScene)scene;
    s.objects.add(new Trail(x, y, this, sender==0?25:100));
  }
  
  void update() {
    float d = dist(x, y, tx, ty);
    float dx = (tx-x)/d;
    float dy = (ty-y)/d;
    x += dx * sp;
    y += dy * sp;
    
    if (d < 10) {
      die = true;
      GameScene s = (GameScene)scene;
      s.objects.add(new Explosion(x, y));
    }
  }
  
  void display() {
    strokeWeight(2);
    stroke(palette[2]);
    float d = dist(x, y, tx, ty);
    float dx = ((tx-x)/d)*5;
    float dy = ((ty-y)/d)*5;
    line(x, y, x-dx, y-dy);
    
    if (sender == 0) {
      stroke(palette[3]);
      strokeWeight(1);
      line(tx-3, ty-3, tx+3, ty+3);
      line(tx+3, ty-3, tx-3, ty+3);
    }
  }
}