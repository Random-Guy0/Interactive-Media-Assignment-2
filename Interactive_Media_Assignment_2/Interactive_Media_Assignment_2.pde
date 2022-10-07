import beads.*;
import java.util.Arrays;

AudioContext ac;
SamplePlayer player;
Envelope speedControl; 
float gainVal; 
float panVal = -1;
int bubbleCount = 1; //this will be used to adjust the gain. 
Bubble b;
Gain g;

void setup()
{
  size(400, 400);
  ac = AudioContext.getDefaultContext();
  selectInput("Select your audio file: ", "fileSelected"); //selecting chatter audiofile
  b = new Bubble(width / 2.0f, height, 1, 30, color(0, 0, 255));
  println(bubbleCount); //printing amount of bubbles. 
}

void fileSelected(File selection) {
  String audioFileName = selection.getAbsolutePath();
  player = new SamplePlayer(SampleManager.sample(audioFileName));
  audioPlayback(); //pops up a dialouge box to select audio, once done it runs the audioPlayback Function 
}

void audioPlayback() {
  Panner p = new Panner(ac, panVal);
  gainVal = gainVal + bubbleCount; //volume adjusted based in bubblecount
  g = new Gain(ac, 2, gainVal);
  p.addInput(player);
  g.addInput(p);  
  ac.out.addInput(g);
  ac.start();
  speedControl = new Envelope(1);
  player.setRate(speedControl);
  
  //Maybe add a function to crossfade to decrease the volume?
  //delay()
  
}



void draw()
{
  clear();
  background(#ffffff);
  b.update();
}
