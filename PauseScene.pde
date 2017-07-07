class PauseScene {
  float t = 0;
  float ot;
  GameScene owner;
  PImage gameScreen;
  boolean wasPausePressed;
  
  Button[] bs;
  
  PauseScene(GameScene owner) {
    super();
    this.owner = owner;
    
    bs = new Button[1];
    ButtonCallback bc0 = new BaseButtonCallback(){void execute(){unpause();}};
    bs[0] = new Button(0, 0, 100, 30, "RESUME", bc0);
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
    fill(255, 10);
    rect(0, 0, width, height);
    
    for (int i=0; i<bs.length; i++)
      bs[i].display();
    
    if (floor(t)%2==0) {
      fill(255);
      textAlign(CENTER, CENTER);
      text("PAUSE", width/2, height/2);
    }
  }
  
  void exit() {}
}