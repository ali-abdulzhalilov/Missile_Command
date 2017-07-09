class GameScene extends Scene {
  boolean wasShootPressed;
  float cursorX, cursorY;
  
  ArrayList<Object> objects;
  Class[] updateOrder = {Base.class, Missile.class, Trail.class, Explosion.class, Enemy.class};
  Class[] renderOrder = {Trail.class, Missile.class, Explosion.class, Base.class, City.class};
  Base[] bs;
  City[] cs;
  int currentBase = 0;
  
  boolean pause = false;
  boolean wasPausePressed = true;
  PauseScene pScene;
  
  GameScene() {
    super();
    noCursor();
    
    objects = new ArrayList<Object>();
    
    bs = new Base[3];
    bs[0] = new Base(0, height);
    bs[1] = new Base((width-50)/2, height);
    bs[2] = new Base(width-50, height);
    
    cs = new City[6];
    cs[0] = new City((width-20)*0.175, height);
    cs[1] = new City((width-20)*0.275, height);
    cs[2] = new City((width-20)*0.375, height);
    cs[3] = new City((width-20)*0.625, height);
    cs[4] = new City((width-20)*0.725, height);
    cs[5] = new City((width-20)*0.825, height);
    
    pScene = new PauseScene(this);
    
    objects.add(new Enemy());
    
    if (scene!=null) scene.exit(); // if there is old scene, let it perform exit action
    enter();
  }
  
  void enter() {}
  
  void loop() {
    if (pause) {
      render();
      pScene.loop();
    }
    else {
      input();
      update();
      render();
    }
  }
  
  void input() {
    for (int i=0; i<bs.length; i++)
      if (bs[i].mouseOnMe())
        currentBase = i;
    
    cursorX = mouseX;
    cursorY = mouseY;
    if (cursorY>height-50) cursorY=height-50;
    
    if (!wasShootPressed && !wasPausePressed) {
      if (mousePressed) {
        int baseIndex = closestAviableBaseIndex(cursorX, cursorY);
        if (baseIndex != -1) {
          bs[baseIndex].shoot();
          wasShootPressed = true;
        }
      }
      if (keyPressed && key==CODED) {
        if (keyCode==LEFT) {bs[0].shoot(); wasShootPressed = true;}
        if (keyCode==UP || keyCode==DOWN) {bs[1].shoot(); wasShootPressed = true;}
        if (keyCode==RIGHT) {bs[2].shoot(); wasShootPressed = true;}
      }
    }
    wasShootPressed = mousePressed || (keyPressed && key==CODED &&
      (keyCode==LEFT||keyCode==UP||keyCode==DOWN||keyCode==RIGHT));
    
    if (keyPressed && key==' ' && !wasPausePressed || !focused) {
      pScene.wasPausePressed = true;
      pause = true;
      pScene.enter();
    }
    wasPausePressed = keyPressed && key==' ';
  }
  
  void update() {
  for (int i = 0; i < updateOrder.length; i++) {
    Class someClass = updateOrder[i];
      int size = objects.size() - 1;
      for (int j = size; j >= 0; j--) {
        if (objects.get(j).getClass() == someClass) {
          Object o = objects.get(j);
          o.update();
          
          if (o.getClass().getSuperclass() == GameObject.class) {
            GameObject go = (GameObject)objects.get(j);
            if (go.die)
              objects.remove(j);
          }
        }
      }
    }
  }
  
  void render() {
    background(palette[12]);
  
    for (int i = 0; i < renderOrder.length; i++) {
      Class someClass = renderOrder[i];
      for (int j = 0; j < objects.size(); j++) {
        if (objects.get(j).getClass() == someClass)
          objects.get(j).display();
      }
    }
    
    for (int i=0; i<bs.length; i++)
      bs[i].display();
      
    for (int i=0; i<cs.length; i++)
      cs[i].display();
      
    strokeWeight(1);
    stroke(palette[2]);
    line(mouseX, mouseY-5, mouseX, mouseY+5);
    line(mouseX-5, mouseY, mouseX+5, mouseY);
    
    float d = 8, d1 = 4;
    noFill();
    stroke(palette[1]);
    line(cursorX+d, cursorY-d, cursorX+d, cursorY+d);
    line(cursorX+d, cursorY-d, cursorX+d-d1, cursorY-d);
    line(cursorX+d, cursorY+d, cursorX+d-d1, cursorY+d);
    line(cursorX-d, cursorY-d, cursorX-d, cursorY+d);
    line(cursorX-d, cursorY-d, cursorX-d+d1, cursorY-d);
    line(cursorX-d, cursorY+d, cursorX-d+d1, cursorY+d);
  }
  
  void exit() {}
  
  int closestAviableBaseIndex(float x, float y) {
    float d = 2147483647;
    int ind = -1;
    
    for (int i = 0; i < bs.length; i++) {
      float temp_d = dist(x, y, bs[i].x+bs[i].w/2, bs[i].y+bs[i].h/2);
      if (temp_d < d && bs[i].missiles > 0) {
        d = temp_d;
        ind = i;
      }
    }
    
    return ind;
  }
}