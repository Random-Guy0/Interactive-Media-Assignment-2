class Circle {
  PVector position;
  PVector velocity;
  color colour;
  float radius, m;

  Circle(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = new PVector(0.5f,0.5f);
    radius = r_;
    m = radius*.1;
    colour = color(180);
  }

  void update() {
    position.add(velocity);
  }
  
  void checkBoundaryCollision() {
    if (position.x > width + radius) {
      position.x = width + radius;
      velocity.x *= -1;
    } else if (position.x < 0.0) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height + radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < 0.0) {
      position.y = radius;
      velocity.y *= -1;
    }
  }

  void display() {
    noStroke();
    fill(colour);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
