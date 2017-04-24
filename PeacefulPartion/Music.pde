import processing.sound.*;

SoundFile soundfile;
SinOsc sine;
LowPass lowPass;
Reverb reverb;
int lowPassCut = 0;
float amp = 0.0;
float room = 0.0;

float C = 65.41;
float D = 73.42;
float E = 82.41;
float F = 87.31;
float G = 98.00;
float A = 110.0;
float B = 123.5;

float C_Scale[] = {C,D,E,F,G,A,B};

void soundSetup(){
  //background music
  soundfile = new SoundFile(this, "Music/"+int(random(2,5)) + ".mp3");
  //soundfile = new SoundFile(this, "Music/test.mp3");
  soundfile.loop(1,0.7); //rate, amp
  
  sine = new SinOsc(this);
  sine.freq(200);
  sine.amp(amp);
  sine.play();
  reverb = new Reverb(this);
  reverb.process(sine);
  reverb.room(room);
  lowPass = new LowPass(this);
}

void soundController(){
  //if(locked && lowPassCut<10000) lowPassCut+=100;
  //if(!locked && lowPassCut>0) lowPassCut-=100;
  //lowPass.process(soundfile, lowPassCut);
  if(locked && amp<1.0) {amp+=0.005; room+=0.005;}
  if(!locked && amp>0) {amp-=0.01; room-=0.01;}
  if (amp > 1.0) amp = 1.0;
  if (amp < 0) amp = 0;
  
  sine.amp(amp); // always outputs an error due to problem with processing sound library
}