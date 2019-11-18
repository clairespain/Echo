import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput in;
AudioOutput out;
MyAudioSocket mySocket;
Delay myDelay;
Flanger flange;

void setup()
{
  size(512, 200);
  minim = new Minim(this);
  myDelay = new Delay(3,1,false,false);
  flange = new Flanger(0, 10, 5, 0.1f, 0.5f, 1);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  int buffer_size = 4096;
  in = minim.getLineIn(Minim.STEREO, buffer_size);
  out = minim.getLineOut(Minim.STEREO, buffer_size);

  // Create the socket to connect input to output
  mySocket = new MyAudioSocket(buffer_size);
  // Connect the socket as a "listener" for the line-in
  in.addListener(mySocket);
  
  //patch directly out, but you can patch into another UGen first
  mySocket.patch(flange).patch(myDelay).patch(out);
}
 
void draw()
{
// erase the window to black
  background( 0 );
  // draw using a white stroke
  stroke( 255 );
  // draw the waveforms
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
  //println(out.getGain());
  println(in.left.level());
}

void keyPressed(){
  switch( key )
  {
    case '1': 
      in.removeListener(mySocket);
      break;
    case '2':
      in.addListener(mySocket);
      break;
    default: 
    break; 
  }
}
