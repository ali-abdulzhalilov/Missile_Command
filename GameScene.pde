class GameScene extends Scene {
  boolean wasShootPressed;
  float cursorX, cursorY;
  
  ArrayList<Object> objects;
  Class[] updateOrder = {Base.class, Missile.class, Trail.class, Explosion.class, Enemy.class};
  Class[] renderOrder = {Trail.class, Missile.class, Explosion.class, Base.class, City.class};
  Base[] bs;
  Enemy e;
  int currentBase = 0;
  
  boolean pause = false;
  boolean wasPausePressed = true;
  PauseScene pScene;
  
  Timer nextTimer;
  float waitToNext = 1;
  
  GameScene() {
    super();
    noCursor();
    
    objects = new ArrayList<Object>();
    
    bs = new Base[3];
    bs[0] = new Base(0, height);
    bs[1] = new Base((width-50)/2, height);
    bs[2] = new Base(width-50, height);
    
    pScene = new PauseScene(this);
    e = new Enemy(1+level/2, 5+level);
    
    nextTimer = new Timer();
    
    if (scene!=null) scene.exit(); // if there is old scene, let it perform exit action
  }
  
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
    e.update();
    
    for (int i = 0; i < updateOrder.length; i++) {
      Class someClass = updateOrder[i];
      for (int j = objects.size() - 1; j >= 0; j--) {
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
    
    if (!nextTimer.running) {
      int missileCount = 0;
      for (int i=0; i<objects.size(); i++) if (objects.get(i).getClass() == Missile.class) missileCount++;
      if (e.waveCount <= 0 && missileCount <= 0) {
        nextTimer.start();
      }
    } else if (nextTimer.currentTime() >= waitToNext) {
      int cityCount = 0;
      for (int i=0; i<cs.length; i++) if (!cs[i].destroyed) cityCount++;
      if (cityCount == 0) 
        scene = new MenuScene(); 
      else {
        level++;
        scene = new GameScene();
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