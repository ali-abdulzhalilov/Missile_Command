Scene scene;

void setup() {
  size(600, 400);
  smooth();
  
  scene = new GameScene();
}

void draw() {
  scene.loop();
}