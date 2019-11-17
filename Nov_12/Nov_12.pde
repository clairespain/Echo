//Author: Claire Spain
//Updated: 12 Nov 2019
//Purpose: Second Sketch Monitor for Interactive Media Project 3; Lips

import ddf.minim.*;
Minim minim;
//AudioPlayer song;
int amplification = 12;
//Microphone
AudioInput in;

//Put Mouth Ani and other visuals in here...

void setup()
{
  //size(1600, 1000, P3D);
  fullScreen();

    minim = new Minim(this);
    
  in = minim.getLineIn(Minim.STEREO, width);

}


void draw()
{
    background(0);
  strokeWeight(5);
  stroke(255);
    //if ( key == 'l' ) in();
    for(int i = 0; i < in.left.size() - 1; i++)
  {
    line(i, height/2 - 100  + in.left.get(i)*500,  i+1, height/2 - 100  + in.left.get(i+1)*50);
    line(i, height/2 + 50 + in.right.get(i)*500, i+1, height/2 + 50 + in.right.get(i+1)*50);
  }

  
}
