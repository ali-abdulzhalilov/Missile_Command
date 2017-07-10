class Timer {
  long startTime;
  long timeSoFar;
  boolean running;
  
  Timer() {
    running = false;
    timeSoFar = 0;
  }
  
  float currentTime() {
    if (running)
      return ((millis()-startTime)/1000.0);
    else
      return (timeSoFar/1000.0);
  }
  
  void start() {
    running = true;
    startTime = millis();
  }
  
  void start(float offset) {
    running = true;
    startTime = millis()-((int)(offset*1000.0));
  }
  
  void restart() {start();};
  
  void pause() {
    if (running) {
      timeSoFar = millis() - startTime;
      running = false;
    }
  }
  
  void continueRunning() {
    if (!running) {
      startTime = millis() - timeSoFar;
      running = false;
    }
  }
}