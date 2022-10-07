//This program is largely based off the "SamplePlayer" example.
import beads.*;
import java.util.Arrays;

AudioContext ac;
SamplePlayer player;
float speedVal = 1; //used to control speed + freq of playback
Envelope speedControl; 
Gain g; 
float gainVal = 0; //used to adjust value of gain/volume
float panVal = -1; //starting value of pan


void setup() {
  size(500,500);
  ac = AudioContext.getDefaultContext();
  selectInput("Select your audio file: ", "fileSelected");
  
}


void fileSelected(File selection) {
  String audioFileName = selection.getAbsolutePath();
  player = new SamplePlayer(SampleManager.sample(audioFileName));
  audioPlayback(); //pops up a dialouge box to select audio, once done it runs the audioPlayback Function 
}




color fore = color(8, 160, 123, 100);
color back = color(0,0,0); 


void draw() {
  //function created from Lesson04_SamplePlayer code for drawing audio wave
  loadPixels();  
  strokeWeight(16);
  //set the background
  Arrays.fill(pixels, back);
  //scan across the pixels
  for(int i = 0; i < width; i++) {
    //for each pixel work out where in the current audio buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    //then work out the pixel height of the audio data at that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
    //draw into Processing's convenient 1-D array of pixels
    vOffset = min(vOffset, height);
    pixels[vOffset * width + i] = fore;
  }
  updatePixels();
}
  
void audioPlayback() {
  draw();
  keyPressed();
  mousePressed();
  Panner p = new Panner(ac, panVal);
  g = new Gain(ac, 2, gainVal);
  p.addInput(player);
  g.addInput(p); //setting up gain, panner and putting it into AC
  ac.out.addInput(g);
  ac.start();
  speedControl = new Envelope(1);
  player.setRate(speedControl);
}

void keyPressed() {
  
  if (key =='r')
  {
    println("playing backwards");
    speedControl.addSegment(-speedVal, 3000); //play audio backwards
  }
  else if (key == 's')
  {
    println("speed increased");
    speedControl.addSegment(speedVal + 1, 1000); //increase speed of audio playback
  }
  else if (key == 'l')
  {
    println("now looping");
    player.setLoopType(SamplePlayer.LoopType.LOOP_ALTERNATING); //begin a loop of audioplayback
  }

}

void mousePressed() {
   panVal = random(-1,1); //change the panning direction of audio playback by changing it to a randoom value [-1,1]
   println("panVal is now" + panVal);
}
