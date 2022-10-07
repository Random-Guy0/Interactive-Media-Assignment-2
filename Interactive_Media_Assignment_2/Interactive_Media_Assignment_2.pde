import controlP5.*;
import beads.*;
import java.util.Arrays;
import java.text.DecimalFormat;

ControlP5 cp5;
AudioContext ac;
SamplePlayer player;
Envelope speedControl; 
float gainVal; 
float panVal = -1;
int bubbleCount = 1; //this will be used to adjust the gain.
Bubble[] bubbles;
Table data;
float dataValue;
DecimalFormat rounded = new DecimalFormat("#");
int roundedValue;
Bubble b;
Gain g;

int month = 1;

void setup()
{
  size(400, 400);
  cp5 = new ControlP5(this);
  data = loadTable("C:/Users/John/Desktop/Interactive-Media-Assignment-2/Interactive_Media_Assignment_2/People CSV.csv");
  bubbles = new Bubble[18];
  ac = AudioContext.getDefaultContext();
  selectInput("Select your audio file: ", "fileSelected"); //selecting chatter audiofile
  for (int i = 0; i < 18; i++) {
    bubbles[i] = new Bubble(random(width / 2.0f), height, 1, 30, color(0, 0, 255));
  }
  dataValue = data.getFloat(month + 1, 1);
  roundedValue = Integer.parseInt(rounded.format(dataValue));
  bubbleCount = roundedValue;
  println(roundedValue);
  // b = new Bubble(width / 2.0f, height, 1, 30, color(0, 0, 255));
  println(bubbleCount); //printing amount of bubbles. 
  
  cp5.addSlider("setMonth").setMin(1).setMax(12).setValue(month).setPosition(10, 20).setSize(200, 30).setCaptionLabel("Month").setSliderMode(Slider.FLEXIBLE).setTriggerEvent(Slider.RELEASED);
  cp5.getController("setMonth").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingY(5).setColor(#000000);
  
}

void fileSelected(File selection) {
  String audioFileName = selection.getAbsolutePath();
  player = new SamplePlayer(SampleManager.sample(audioFileName));
  audioPlayback(); //pops up a dialouge box to select audio, once done it runs the audioPlayback Function 
  // b = new Bubble(width / 2.0, height, 20.0, 30, color(0, 0, 255));
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
  dataValue = data.getFloat(month + 1, 1);
  roundedValue = Integer.parseInt(rounded.format(dataValue));
  for (int i = 0; i < bubbleCount; i++) {
          bubbles[i].update(0.5);
      }
  if (roundedValue > bubbleCount) {
      for (int i = bubbleCount; i < roundedValue; i++) {
          bubbles[i].update(0.5);
      }
  }
  if (bubbleCount > roundedValue) {
      // bubble pop method
  }
  println(dataValue);
  // b.update();
}

void setMonth(int month)
{
  this.month = month;
  
  setMonthLabel(month);
}

void setMonthLabel(int currentMonth)
{
  Label valueLabel = cp5.getController("setMonth").getValueLabel();
  
  switch(currentMonth)
  {
    case 1:
      valueLabel.setText("January");
      break;
    case 2:
      valueLabel.setText("February");
      break;
    case 3:
      valueLabel.setText("March");
      break;
    case 4:
      valueLabel.setText("April");
      break;
    case 5:
      valueLabel.setText("May");
      break;
    case 6:
      valueLabel.setText("June");
      break;
    case 7:
      valueLabel.setText("July");
      break;
    case 8:
      valueLabel.setText("August");
      break;
    case 9:
      valueLabel.setText("September");
      break;
    case 10:
      valueLabel.setText("October");
      break;
    case 11:
      valueLabel.setText("November");
      break;
    case 12:
      valueLabel.setText("December");
      break;
  }
}
