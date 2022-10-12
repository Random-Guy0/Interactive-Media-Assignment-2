class Bubble extends MoveableObject
{
  float radius;
  color bubbleColor;
  Bubble[] bubbles;
  float waveHeight = 3;
  boolean on = false;
  float amplitude = 4;
  float wavelength = 0.4;
  
  Bubble()
  {
    super();
    this.radius = 1.0;
    this.bubbleColor = color(0, 0, 255);
    bubbleCount++;
    
    //once data is quieter, deincrement bubblecount
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
    position.y -= speed * deltaTime;
    position.x = initialPosition.x + amplitude * sin(position.y * wavelength);
    noStroke();
    fill(bubbleColor);
    circle(position.x, position.y, radius);
    collision();
  }
  
  void collision() {
    if (position.y + radius/2 < height && position.y - radius/2 > 0 && position.x + radius/2 < width && position.x - radius/2 > 0) {
      on = true;
    }
    if ((position.y + radius/2 > height || position.y - radius/2 < 0) && on == true) {
      speed *= -1;
    }
    for (Bubble bubble : bubbles) {
      if (bubble != this && on == true) {
        float xValue = pow((bubble.position.x - position.x),2);
        float yValue = pow((bubble.position.y - position.y),2);
        float lengths = sqrt(xValue + yValue);
        if (lengths <= (bubble.radius + radius)) {
          bubble.speed *= -1;
          speed *= -1;
        }
      }
    }
  }
}
