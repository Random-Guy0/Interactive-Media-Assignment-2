import controlP5.*;
import beads.*;
import java.util.Arrays;

ControlP5 cp5;
AudioContext ac;
SamplePlayer player;
Envelope speedControl; 
float gainVal; 
float gainMult = 1;
float panVal = -1;
Table data;
ArrayList<Bubble> bubbles;
Gain g;

int month = 2;

void setup()
{
  size(400, 400);
  bubbles = new ArrayList<Bubble>();
  cp5 = new ControlP5(this);
  data = loadTable("People CSV.csv");
  println(data.getRowCount());
  ac = AudioContext.getDefaultContext();
  selectInput("Select your audio file: ", "fileSelected"); //selecting chatter audiofile
  bubbles.add(new Bubble(width / 2.0f + 10, height, 10, 30, color(0, 0, 255)));
  bubbles.add(new Bubble(width / 2.0f - 10, height, 10, 30, color(0, 0, 255)));
  println(bubbles.size()); //printing amount of bubbles. 
  
  cp5.addSlider("setMonth").setMin(2).setMax(8).setValue(month).setPosition(10, 20).setSize(200, 30).setCaptionLabel("Month").setSliderMode(Slider.FLEXIBLE);
  cp5.getController("setMonth").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingY(5).setColor(#000000);
  
}

void fileSelected(File selection) {
  String audioFileName = selection.getAbsolutePath();
  player = new SamplePlayer(SampleManager.sample(audioFileName));
  audioPlayback(); //pops up a dialouge box to select audio, once done it runs the audioPlayback Function 
}

void audioPlayback() {
  Panner p = new Panner(ac, panVal);
  gainVal = gainMult * bubbles.size(); //volume adjusted based in bubblecount
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
  
  gainVal = gainMult * bubbles.size();
  if(g != null)
    g.setGain(gainVal);
  
  detectCollisions();
  for(Bubble bubble : bubbles)
  {
    bubble.update();
  }
}

void detectCollisions()
{
  for(int i = 0; i < bubbles.size(); i++)
  {
    for(int j = 0; j < bubbles.size(); j++)
    {
      if(i != j)
      {
        float distance = PVector.dist(bubbles.get(i).position, bubbles.get(j).position);
        float collisionDistance = bubbles.get(i).radius + bubbles.get(j).radius;
        
        if(distance < collisionDistance)
        {
          bubbles.get(i).collision();
          break;
        }
      }
    }
  }
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
