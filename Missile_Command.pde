Scene scene;
int level = 0;
color[] palette;
City[] cs;

void setup() {
  size(600, 400);
  smooth();
  
  palette = new color[16]; // arne palette
  palette[0]  = #000000; // void
  palette[1]  = #9D9D9D; // gray
  palette[2]  = #FFFFFF; // white
  palette[3]  = #BE2633; // red
  palette[4]  = #E06F8B; // meat
  palette[5]  = #493C2B; // darkbrown
  palette[6]  = #A46422; // brown
  palette[7]  = #EB8931; // orange
  palette[8]  = #F7E26B; // yellow
  palette[9]  = #2F484E; // darkgreen
  palette[10] = #44891A; // green
  palette[11] = #A3CE27; // slimegreen
  palette[12] = #1B2632; // nightblue
  palette[13] = #005784; // seablue
  palette[14] = #31A2F2; // skyblue
  palette[15] = #B2DCEF; // cloudblue
  
  scene = new MenuScene();
  scene.enter();
}

void draw() {
  scene.loop();
}