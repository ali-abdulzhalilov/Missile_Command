class PauseScene {
  float t = 0;
  float ot;
  final GameScene owner;
  PImage gameScreen;
  boolean wasPausePressed;
  
  Button[] bs;
  
  PauseScene(GameScene owner) {
    super();
    this.owner = owner;
    
    bs = new Button[3];
    ButtonCallback bc0 = new BaseButtonCallback(){void execute(){unpause();}};
    bs[0] = new Button(width/2-50, height/2-30, 100, 30, "RESUME", bc0);
    ButtonCallback bc1 = new BaseButtonCallback(){void execute(){scene = new GameScene();}};
    bs[1] = new Button(width/2-50, height/2, 100, 30, "RESTART", bc1);
    ButtonCallback bc2 = new BaseButtonCallback(){void execute(){scene=new MenuScene();}};
    bs[2] = new Button(width/2-50, height/2+30, 100, 30, "MAIN MENU", bc2);
  }
  
  void enter() {
    t = 0;
    ot = millis();
    gameScreen = get();
    cursor(ARROW);
  }
  
  void loop() {
    input();
    update();
    render();
  }
  
  void input() {
    if (keyPressed && key==' ' && !wasPausePressed)
      unpause();
    wasPausePressed = keyPressed && key==' ';
    
    for (int i=0; i<bs.length; i++)
      bs[i].input();
  }
  
  void unpause() {
    owner.wasPausePressed = true;
    owner.pause = false;
    this.exit();
    noCursor();
  }
  
  void keyPressed() {
    println("BLOP");
  }
  
  void update() {
    t += (millis() - ot) / 1000;
    ot = millis();
  }
  
  void render() {
    image(gameScreen, 0, 0);
    noStroke();
    fill(palette[13]);
    //rect(0, 0, 100, height);
    rect(width/2-60, height/2-70, 120, 140);
    
    for (int i=0; i<bs.length; i++)
      bs[i].display();
    
    if (floor(t)%2==0) {
      fill(palette[2]);
      textAlign(CENTER, CENTER);
      text("PAUSE", width/2, height/2-50);
    }
  }
  
  void exit() {}
}