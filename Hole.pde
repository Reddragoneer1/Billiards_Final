class Hole
{
  float rad;
  Point center;
  color col = 255;
  
  Hole(float x, float y)
  {
    center = new Point();
    center.point.x = x;
    center.point.y = y;
  }
  void displayHole()
  {
    fill(0);
    ellipse(center.point.x, center.point.y, 2*rad, 2*rad);
  }
  boolean check_hole(Ball b)
  {
    float xDist = b.center.point.x - center.point.x;
    float yDist = b.center.point.y - center.point.y;
    float distance = rad+b.rad;
    if(xDist*xDist + yDist*yDist < distance * distance /2)
      return true;
    else
      return false;
    
  }
  
}