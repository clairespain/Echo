//Import some stuff.
import ddf.minim.*;
import ddf.minim.ugens.*;

//Variables
Minim minim;
AudioInput in;
AudioOutput out, out2, out3;
MyAudioSocket mySocket, mySocket2, mySocket3;
Delay reverb, reverb2, reverb3;
Delay delayer, delayer2, delayer3;
TickRate pitchUp, pitchDown;
boolean fading = false;
//int alarm;  <--Experimental.  Doesn't work as well as we thought.

void setup()
{
  //Declare some things.
  size(512, 200);
  minim = new Minim(this);

  //For that sweet echo.
  reverb = new Delay(0.2, 0.5, true, false);
  reverb2 = new Delay(0.3, 0.5, true, false);
  reverb3 = new Delay(0.1, 0.5, true, false);

  //So we don't talk over each other.
  delayer = new Delay(0.2, 1, false, false);
  delayer2 = new Delay(0.3, 1, false, false);
  delayer3 = new Delay(0.1, 1, false, false);

  //Chipmunks and Barry White.
  pitchUp = new TickRate(2);
  pitchDown = new TickRate(0.5);

  //minim.debugOn(); <-- Off, but here if needed.

  //Establish our I/O.  Turns out Mono doesn't really do anything.
  int buffer_size = 4096;
  in = minim.getLineIn(Minim.MONO, buffer_size);
  out = minim.getLineOut(Minim.MONO, buffer_size);
  out2 = minim.getLineOut(Minim.MONO, buffer_size);
  out3 = minim.getLineOut(Minim.MONO, buffer_size);

  //Create the socket to connect input to output.
  //This lets us treat our standard AudioInput as a UGen.
  mySocket = new MyAudioSocket(buffer_size);
  mySocket2 = new MyAudioSocket(buffer_size);
  mySocket3 = new MyAudioSocket(buffer_size);

  //Connect the socket as a "listener" for the line-in.
  in.addListener(mySocket);
  in.addListener(mySocket2);
  in.addListener(mySocket3);

  //Patch our socket through our modifiers and play them out.
  mySocket/*.patch(flange)*/.patch(reverb).patch(delayer).patch(out);
  mySocket2.patch(reverb2).patch(pitchUp).patch(delayer2).patch(out2);
  mySocket3.patch(reverb3).patch(pitchDown).patch(delayer3).patch(out3);
}

void draw()
{
  //A place for the thing
  background(0);
  stroke(255);

  //Testing Lines
  //println("Line In " + in.left.level());
  //println(fading);
  //println("Out Gain " + out.getGain());
  //println("Timer " + millis());
  //println("Alarm " + alarm);
  if(in.left.level() >= 0.3 && fading == false){
    fader();
    //alarm = millis(); <-- Again, b0rked.
  } else if(in.left.level() <= 0.01 && fading == true /*|| millis() - alarm < 15000 <-- See previous comment.*/){
    riser();
  }
}

//This brings our volume down if things get to spicy.
void fader(){
  out.shiftGain(0, -24, 750);
  out2.shiftGain(0, -24, 750);
  out3.shiftGain(0, -24, 750);
  fading = true;
}

//This brings our volume back up when things get too boring.
void riser(){
  fading = false;
  out.shiftGain(-23, 0, 15000);
  out2.shiftGain(-23, 0, 20000);
  out3.shiftGain(-23, 0, 10000);
}

//Emergency Kill Switch/Nuke Option
void keyPressed(){
  switch(key)
  {
  case '1': 
    in.removeListener(mySocket);
    in.removeListener(mySocket2);
    in.removeListener(mySocket3);
    out.shiftGain(0, -60, 500);
    out2.shiftGain(0, -60, 500);
    out3.shiftGain(0, -60, 500);
    break;
  case '2':
    in.addListener(mySocket);
    in.addListener(mySocket2);
    in.addListener(mySocket3);
    out.shiftGain(-58, 0, 500);
    out2.shiftGain(-58, 0, 500);
    out3.shiftGain(-58, 0, 500);
    break;
  default: 
    break;
  }
}
