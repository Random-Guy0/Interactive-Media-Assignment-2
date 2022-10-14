class Bubble extends MoveableObject
{
  float radius;
  color bubbleColor;
  
  float waveHeight = 3;
  boolean on = false;
  float amplitude = 4;
  float wavelength = 0.4;
  int waveDir = 1;
  
  boolean popped = false;
  
  Bubble()
  {
    super();
    this.radius = 1.0;
    this.bubbleColor = color(0, 0, 255);
    
    this.waveDir = 2 * (int(random(0, 1)) - 1);
  }
  
  Bubble(float x, float y, float speed)
  {
    super(x, y, speed);
    this.radius = 1.0f;
    this.bubbleColor = color(0, 0, 255);
    
    this.waveDir = int(2 * (int(random(0, 2)) / 0.5 - 1));
  }
  
  Bubble(float x, float y, float speed, float radius, color bubbleColor)
  {
    super(x, y, speed);
    this.radius = radius;
    this.bubbleColor = bubbleColor;
    
    this.waveDir = int(int(random(0, 2)) / 0.5 - 1);
  }
  
  Bubble(PVector position, float speed, float radius, color bubbleColor)
  {
    super(position, speed);
    this.radius = radius;
    this.bubbleColor = bubbleColor;
    
    this.waveDir = 2 * (int(random(0, 2)) - 1);
  }
  
  Bubble(float radius, color bubbleColor)
  {
    super();
    this.radius = radius;
    this.bubbleColor = bubbleColor;
    
    this.waveDir = 2 * (int(random(0, 2)) - 1);
  }
  
  void update(float deltaTime)
  {
    position.y -= speed * deltaTime;
    position.x = initialPosition.x + amplitude * sin(position.y * wavelength) * waveDir;
    noStroke();
    fill(bubbleColor);
    circle(position.x, position.y, radius);
  }
}
