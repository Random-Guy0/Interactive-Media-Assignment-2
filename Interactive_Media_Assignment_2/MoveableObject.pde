class MoveableObject
{
  PVector position;
  PVector velocity;
  
  MoveableObject()
  {
    this(new PVector(), new PVector());
  }
  
  MoveableObject(float x, float y)
  {
    this(new PVector(x, y), new PVector());
  }
  
  MoveableObject(float x, float y, PVector velocity)
  {
    this(new PVector(x, y), velocity);
  }
  
  MoveableObject(PVector position, PVector velocity)
  {
    this.position = position;
    this.velocity = velocity;
  }
  
  void update()
  {
    update(0);
  }
  
  void update(float deltaTime)
  {
    
  }
}
