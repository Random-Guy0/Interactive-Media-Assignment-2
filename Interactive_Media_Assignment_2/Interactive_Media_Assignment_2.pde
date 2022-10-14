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
Ball[] balls;
Table data;
float dataValue;
DecimalFormat rounded = new DecimalFormat("#");
int prevBubbleCount;
float temp;
int tempRound;
Gain g;
PVector[] starting = {new PVector(0, random(400)), new PVector(400, random(400)), new PVector(random(400), 0), new PVector(random(400), 400)};
int month = 1;

void setup()
{
  size(400, 400);
  background(150);
  cp5 = new ControlP5(this);
  data = loadTable("C:/Users/John/Desktop/Interactive-Media-Assignment-2/Interactive_Media_Assignment_2/People CSV.csv");
  println(data);
  balls = new Ball[18];
  ac = AudioContext.getDefaultContext();
  selectInput("Select your audio file: ", "fileSelected"); //selecting chatter audiofile
  for (int i = 0; i < 18; i++) {
    balls[i] = new Ball(random(400), random(400), 10.0f);
  }
  dataValue = data.getFloat(month + 1, 1);
  prevBubbleCount = (int)Math.round(dataValue);
  cp5.addSlider("setMonth").setMin(1).setMax(7).setValue(month).setPosition(10, 20).setSize(200, 30).setCaptionLabel("Month").setSliderMode(Slider.FLEXIBLE).setTriggerEvent(Slider.RELEASED);
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
  background(200);
  dataValue = data.getFloat(month + 1, 1);
  bubbleCount = (int)Math.round(dataValue);
  temp = data.getFloat(month + 1, 3);
  for (int i = 0; i < prevBubbleCount; i++) {
   if (20 < temp && temp < 30) {
      balls[i].colour = color(255,0,0);
    } else if (10 < temp && temp < 20) {
      balls[i].colour = color(255,165,0);
    } else if (0 < temp && temp < 10) {
      balls[i].colour = color(255,215,0);
    }
  }
  println("PrevBubbleCount " + prevBubbleCount);
  println("BubbleCount " + bubbleCount);
  prevBubbleCount = bubbleCount;
    for (int i = 0; i < prevBubbleCount; i++) {
     for (int j = 0; j < prevBubbleCount; j++) {
        if (balls[i] != null && balls[j] != null) {
          balls[i].update();
          balls[i].display();
          balls[i].checkBoundaryCollision();
          if (i != j) {
            balls[i].checkCollision(balls[j]);
          }
        }
      }
    }
  println("PrevBubbleCount " + prevBubbleCount);
  println("BubbleCount " + bubbleCount);
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
      valueLabel.setText("February");
      break;
    case 2:
      valueLabel.setText("March");
      break;
    case 3:
      valueLabel.setText("April");
      break;
    case 4:
      valueLabel.setText("May");
      break;
    case 5:
      valueLabel.setText("June");
      break;
    case 6:
      valueLabel.setText("July");
      break;
    case 7:
      valueLabel.setText("August");
      break;
  }
}
