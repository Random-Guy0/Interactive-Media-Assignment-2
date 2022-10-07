class Bubble extends MoveableObject
{
  float radius;
  color bubbleColor;
  
  float waveHeight = 3;
  
  Bubble()
  {
    super();
    this.radius = 1.0f;
    this.bubbleColor = color(0, 0, 255);
  }
  
  Bubble(float x, float y, float speed)
  {
    super(x, y, speed);
    this.radius = 1.0f;
    this.bubbleColor = color(0, 0, 255);
  }
  
  Bubble(float x, float y, float speed, float radius, color bubbleColor)
  {
    super(x, y, speed);
    this.radius = radius;
    this.bubbleColor = bubbleColor;
  }
  
  Bubble(PVector position, float speed, float radius, color bubbleColor)
  {
    super(position, speed);
    this.radius = radius;
    this.bubbleColor = bubbleColor;
  }
  
  Bubble(float radius, color bubbleColor)
  {
    super();
    this.radius = radius;
    this.bubbleColor = bubbleColor;
  }
  
  void update(float deltaTime)
  {
    position.y -= speed;
    position.x += waveHeight * sin(position.y);
    noStroke();
    fill(bubbleColor);
    circle(position.x, position.y, radius);
  }
}
