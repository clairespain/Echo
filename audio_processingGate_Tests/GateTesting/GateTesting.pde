import processing.sound.*;
AudioIn in;
Amplitude amp;
Delay delay;

void setup() {
  size(640, 360);
  background(255);
    
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  delay = new Delay(this);
  
  in.start();
  amp.input(in);
}      

void draw() {
  
  println(amp.analyze());
  //Gate Code.  Currently breaks if "else if" (or just "if" or "else") is implemented.
  //This is because amp.analyze stops returning absolute values to ten decimal
  //places and instead drops into normal floats out to 10x^-7 as soon as the amplitude 
  //of "in" drops out.
  if(amp.analyze() >= 0.1){
    delay.process(in, 3.0, 3.0);
    in.play(1.0);
  } //else if (amp.analyze() <= 0.01) {
  //  in.play(0.0001);
  //}
  
  
}
