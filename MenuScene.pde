class MenuScene extends Scene {
  Button[] bs;
  
  MenuScene() {
    super();
    cursor(ARROW);
    
    bs = new Button[1];
    ButtonCallback bc0 = new BaseButtonCallback(){void execute(){scene = new GameScene();}};
    bs[0] = new Button(width/2-50, height/2-15, 100, 30, "PLAY", bc0);
    
    cs = new City[6];
    cs[0] = new City((width-20)*0.175, height);
    cs[1] = new City((width-20)*0.275, height);
    cs[2] = new City((width-20)*0.375, height);
    cs[3] = new City((width-20)*0.625, height);
    cs[4] = new City((width-20)*0.725, height);
    cs[5] = new City((width-20)*0.825, height);
    
    level = 0;
  }
  
  void loop() {
    input();
    update();
    render();
  }
  
  void input() {
    for (int i=0; i<bs.length; i++)
      bs[i].input();
  }
  
  void render() {
    background(palette[0]);
    
    for (int i=0; i<bs.length; i++)
      bs[i].display();
  }
}