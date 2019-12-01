import java.util.concurrent.TimeUnit;
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

void setup()
{
  size(512, 200);
  minim = new Minim(this);

  reverb = new Delay(0.2, 0.5, true, false);
  reverb2 = new Delay(0.3, 0.5, true, false);
  reverb3 = new Delay(0.1, 0.5, true, false);
  
  delayer = new Delay(0.2, 1, false, false);
  delayer2 = new Delay(0.3, 1, false, false);
  delayer3 = new Delay(0.1, 1, false, false);
  
  pitchUp = new TickRate(2);
  pitchDown = new TickRate(0.5);

  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  int buffer_size = 4096;
  
  in = minim.getLineIn(Minim.MONO, buffer_size);
  out = minim.getLineOut(Minim.MONO, buffer_size);
  out2 = minim.getLineOut(Minim.MONO, buffer_size);
  out3 = minim.getLineOut(Minim.MONO, buffer_size);
  
  // Create the socket to connect input to output
  mySocket = new MyAudioSocket(buffer_size);
  mySocket2 = new MyAudioSocket(buffer_size);
  mySocket3 = new MyAudioSocket(buffer_size);
  
  // Connect the socket as a "listener" for the line-in
  in.addListener(mySocket);
  in.addListener(mySocket2);
  in.addListener(mySocket3);
  
  //patch directly out, but you can patch into another UGen first
  mySocket/*.patch(flange)*/.patch(reverb).patch(delayer).patch(out);
  mySocket2.patch(reverb2).patch(pitchUp).patch(delayer2).patch(out2);
  mySocket3.patch(reverb3).patch(pitchDown).patch(delayer3).patch(out3);
  

}

void draw()
{
  // erase the window to black
  background( 0 );
  // draw using a white stroke
  stroke( 255 );
  // draw the waveforms
  //for ( int i = 0; i < out.bufferSize() - 1; i++ )
  //{
  //  // find the x position of each buffer value
  //  float x1  =  map( i, 0, out.bufferSize(), 0, width );
  //  float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
  //  // draw a line from one buffer position to the next for both channels
  //  line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
  //  line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);

  //tick = millis();
  //String time = String.format("%d hrs, %d min, %d sec", TimeUnit.MILLISECONDS.toHours(tick), TimeUnit.MILLISECONDS.toMinutes(tick), TimeUnit.MILLISECONDS.toSeconds(tick) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(tick)));
  //textSize(24);
  //textAlign(CENTER);
  //text(time, width / 2, height / 2);

  println("Line In " + in.left.level());
  //println(fading);
  println("Out Gain " + out.getGain());
  //println(tick);

  if(in.left.level() >= 0.3 && fading == false){
    fader();
  } else if(in.left.level() <= 0.01 && fading == true){
    riser();
  }
}

void fader() {
    out.shiftGain(0, -24, 1000);
    out2.shiftGain(0, -24, 1000);
    out3.shiftGain(0, -24, 1000);
    fading = true;
}

void riser() {
    out.shiftGain(-25, 0, 40000);
    out2.shiftGain(-25, 0, 30000);
    out3.shiftGain(-25, 0, 20000);
    fading = false;
}

void keyPressed() {
  switch( key )
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
