Bubble b;

void setup()
{
  size(400, 400);
  b = new Bubble(width / 2.0, height, 20.0, 30, color(0, 0, 255));
}

void draw()
{
  clear();
  background(#ffffff);
  b.update();
}
