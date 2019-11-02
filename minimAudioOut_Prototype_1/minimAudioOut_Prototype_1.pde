//adapted from kdge https://processing.org/discourse/beta/num_1200857589.html

import ddf.minim.*;

Minim minim;
AudioInput in;
AudioOutput out;
WaveformRenderer waveform;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
  out = minim.getLineOut(Minim.STEREO, 512);

  waveform = new WaveformRenderer();
  in.addListener(waveform);


  // adds the signal to the output
  out.addSignal(waveform);

}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  out.close();

  minim.stop();

  super.stop();
}


class WaveformRenderer implements AudioListener, AudioSignal
{

  private float[] left;
  private float[] right;

  WaveformRenderer()
  {
    //    left = null; 
    //    right = null;
  }

  synchronized void samples(float[] samp)
  {
    left = samp;
  }

  synchronized void samples(float[] sampL, float[] sampR)
  {
    left = sampL;
    right = sampR;
  }


  void generate(float[] samp)
  {
    System.arraycopy(right, 0, samp, 0, samp.length);

  }

  // this is a stricly mono signal
  void generate(float[] sampL, float[] sampR)
  {
    if (left!=null && right!=null){
      System.arraycopy(left, 0, sampL, 0, sampL.length);
      System.arraycopy(right, 0, sampR, 0, sampR.length);
    }
  }


}
 
