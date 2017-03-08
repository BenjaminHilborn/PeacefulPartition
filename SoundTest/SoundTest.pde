import processing.sound.*;

SinOsc sine;
Reverb reverb;

void setup() {
  size(640, 360);
  background(255);
    
  // Create the sine oscillator.
  sine = new SinOsc(this);
  sine.play();
  reverb.process(sine);
  reverb.room(10);
}

float freq=1000;
void draw() {
  while(true){
    freq = (freq + (freq * random(-0.1, 0.1)));
    sine.freq(freq);
  }
}