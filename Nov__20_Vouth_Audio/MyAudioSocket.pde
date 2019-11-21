class MyAudioSocket extends UGen implements AudioListener
{
 
  private float[] left;
  private float[] right;
  private int buffer_max;
  private int inpos, outpos;
  private int count;
 
  MyAudioSocket(int buffer_size)
  {
     int n_buffers = 4;
     buffer_max = n_buffers * buffer_size;
     left = new float[buffer_max];
     right = new float[buffer_max];
     inpos = 0;
     outpos = 0;
     count = 0;
  }
 
  // The AudioListener:samples method accepts new input samples
  synchronized void samples(float[] samp)
  {
    // handle mono by writing samples to both left and right
    samples(samp, samp);
  }
 
  synchronized void samples(float[] sampL, float[] sampR)
  {
    System.arraycopy(sampL, 0, left, inpos, sampL.length);
    System.arraycopy(sampR, 0, right, inpos, sampR.length);
    inpos += sampL.length;
    if (inpos == buffer_max) {
      inpos = 0;
    }
    count += sampL.length;
 
  }
 
 
  //if I understand this correctly, UGens operate on a per sample basis
  //Override
  protected void uGenerate(float[] channels) 
  {
    if (count > 0) {
      for(int n = 0; n <channels.length; n++){
       channels[n] = ((n&1) == 0)?left[outpos]:right[outpos]; 
      }
      outpos++;
      if (outpos == buffer_max) {
         outpos = 0;
       }
      count--;
    }
 
  }
 
}
