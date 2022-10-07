class MoveableObject
{
  PVector position;
  //PVector velocity;
  float speed;
  
  float deltaTime;
  
  float lastTime = second();
  
  MoveableObject()
  {
    this(new PVector(), 1.0f);
  }
  
  MoveableObject(float x, float y, float speed)
  {
    this(new PVector(x, y), speed);
  }
  
  MoveableObject(PVector position, float speed)
  {
    this.position = position;
    this.speed = speed;
  }
  
  void update()
  {
    deltaTime = second() - lastTime;
    lastTime = second();
    update(deltaTime);
  }
  
  void update(float deltaTime)
  {
    
  }
}
