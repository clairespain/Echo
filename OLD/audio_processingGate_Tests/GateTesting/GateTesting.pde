//Bring in all our special settings
import processing.sound.*;
Sound s;
AudioIn in;
Amplitude amp;
Delay delay;

//Volume variable
float vol = 1.0;

void setup() {
  //A thing to hold the thing.
  size(640, 360);
  background(255);
  
  //Instantiate all our settings
  s = new Sound(this);
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  delay = new Delay(this);
  
  //This is our audio player with a delay.  It also contains our amp analyzer.
  in.play();
  delay.process(in, 3.0, 3.0);
  amp.input(in);
}      

void draw() {
  //Don's Fool-Proof Testing Lines(TM).
  //println(vol);
  //println(amp.analyze());
  
  //Gate Code.  Now controls the entire sound processing volume instead of amplitude.
  //Be aware that volume only accepts values between 0.0 and 1.0, including those two values.
  if(amp.analyze() >= 0.1){
    vol = 1.0;
  } else if (amp.analyze() <= 0.01) {
    vol = 0.0;
  }
    s.volume(vol);
}
