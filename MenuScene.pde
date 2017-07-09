class MenuScene extends Scene {
  Button[] bs;
  
  MenuScene() {
    super();
    
    bs = new Button[1];
    ButtonCallback bc0 = new BaseButtonCallback(){void execute(){scene = new GameScene();}};
    bs[0] = new Button(width/2-50, height/2-15, 100, 30, "PLAY", bc0);
  }
  
  void enter() {}
  
  void loop() {
    input();
    update();
    render();
  }
  
  void input() {
    for (int i=0; i<bs.length; i++)
      bs[i].input();
  }
  
  void update() {}
  
  void render() {
    background(palette[0]);
    
    for (int i=0; i<bs.length; i++)
      bs[i].display();
  }
  
  void exit() {}
}