class MoveableObject
{
  PVector position;
  PVector initialPosition;
  //PVector velocity;
  float speed;
  
  float deltaTime;
  
  float lastTime = millis();
  float lastCollisionTime = -1;
  
  MoveableObject()
  {
    this(new PVector(), 1.0);
  }
  
  MoveableObject(float x, float y, float speed)
  {
    this(new PVector(x, y), speed);
  }
  
  MoveableObject(PVector position, float speed)
  {
    this.position = position.copy();
    this.speed = speed;
    this.initialPosition = position.copy();
  }
  
  void update()
  {
    deltaTime = (millis() - lastTime) / 1000.0;
    lastTime = millis();
    update(deltaTime);
  }
  
  void update(float deltaTime)
  {
    
  }
  
  void collision()
  {
    
  }
}
