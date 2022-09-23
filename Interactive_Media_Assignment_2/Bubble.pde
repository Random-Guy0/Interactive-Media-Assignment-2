class Bubble extends MoveableObject
{
  float radius;
  color bubbleColor;
  
  Bubble()
  {
    super();
  }
  
  Bubble(float x, float y)
  {
    super(x, y);
  }
  
  Bubble(float x, float y, PVector velocity)
  {
    super(x, y, velocity);
  }
  
  Bubble(PVector position, PVector velocity)
  {
    super(position, velocity);
  }
  
  Bubble(float radius, color bubbleColor)
  {
    this();
    this.radius = radius;
    this.bubbleColor = bubbleColor;
  }
}
